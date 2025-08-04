# RDS用のランダムパスワード生成
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# RDS用セキュリティグループ
resource "aws_security_group" "rds" {
  name_prefix = "${var.project_name}-${var.environment}-rds-"
  vpc_id      = var.vpc_id

  # WebサーバーからのMySQL接続を許可
  ingress {
    description     = "MySQL from Web Servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_server_security_group_id]
  }

  # VPC内からのMySQL接続を許可（管理用）
  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # アウトバウンド通信を許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-rds-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# RDS サブネットグループ
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-subnet-group"
  })
}

# RDS パラメータグループ
resource "aws_db_parameter_group" "main" {
  family = "${var.engine}${var.engine_version}"
  name   = "${var.project_name}-${var.environment}-params"

  # 日本語文字化け対策
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }

  # クエリログを有効化（開発・検証用）
  parameter {
    name  = "general_log"
    value = "1"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "2"
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-params"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# RDS オプショングループ
resource "aws_db_option_group" "main" {
  name                     = "${var.project_name}-${var.environment}-options"
  option_group_description = "Option group for ${var.project_name} ${var.environment}"
  engine_name              = var.engine
  major_engine_version     = var.engine_version

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-options"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# AWS Secrets Managerにパスワードを保存
resource "aws_secretsmanager_secret" "db_password" {
  name        = "${var.project_name}-${var.environment}-db-password"
  description = "Database password for ${var.project_name} ${var.environment}"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    endpoint = aws_db_instance.main.endpoint
    port     = aws_db_instance.main.port
    dbname   = var.db_name
  })
}

# RDS インスタンス（MultiAZ構成）
resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-${var.environment}-db"

  # エンジン設定
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  # ストレージ設定
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp2"
  storage_encrypted     = true

  # データベース設定
  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result

  # ネットワーク設定
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  # High Availability設定
  multi_az = true

  # バックアップ設定
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window
  copy_tags_to_snapshot  = true

  # パラメータ・オプショングループ
  parameter_group_name = aws_db_parameter_group.main.name
  option_group_name    = aws_db_option_group.main.name

  # モニタリング設定
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  # セキュリティ設定
  deletion_protection   = var.deletion_protection
  skip_final_snapshot   = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.project_name}-${var.environment}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  # ログ設定
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  # 自動マイナーバージョンアップデートを無効化
  auto_minor_version_upgrade = false

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db"
  })

  depends_on = [aws_iam_role_policy_attachment.rds_monitoring]
}

# RDS モニタリング用IAMロール
resource "aws_iam_role" "rds_monitoring" {
  name = "${var.project_name}-${var.environment}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# モニタリング用ポリシーのアタッチ
resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
