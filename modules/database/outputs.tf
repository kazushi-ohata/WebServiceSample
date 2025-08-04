output "db_instance_id" {
  description = "RDS インスタンスID"
  value       = aws_db_instance.main.id
}

output "db_instance_endpoint" {
  description = "RDS エンドポイント"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_port" {
  description = "RDS ポート"
  value       = aws_db_instance.main.port
}

output "db_instance_arn" {
  description = "RDS インスタンスARN"
  value       = aws_db_instance.main.arn
}

output "db_subnet_group_name" {
  description = "DB サブネットグループ名"
  value       = aws_db_subnet_group.main.name
}

output "db_security_group_id" {
  description = "RDS セキュリティグループID"
  value       = aws_security_group.rds.id
}

output "db_parameter_group_name" {
  description = "DB パラメータグループ名"
  value       = aws_db_parameter_group.main.name
}

output "db_option_group_name" {
  description = "DB オプショングループ名"
  value       = aws_db_option_group.main.name
}

output "secrets_manager_secret_arn" {
  description = "Secrets Manager シークレットARN"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "db_name" {
  description = "データベース名"
  value       = var.db_name
}

output "db_username" {
  description = "データベースユーザー名"
  value       = var.db_username
  sensitive   = true
}