variable "aws_region" {
  description = "AWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "project_name" {
  description = "プロジェクト名"
  type        = string
  default     = "webservice-sample"
}

variable "environment" {
  description = "環境名"
  type        = string
  default     = "prd"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "利用するアベイラビリティゾーン"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "public_subnet_cidrs" {
  description = "PublicサブネットのCIDRブロック"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "PrivateサブネットのCIDRブロック"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

# Compute関連の変数
variable "instance_type" {
  description = "EC2インスタンスタイプ"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "EC2キーペア名"
  type        = string
  default     = ""
}

variable "min_size" {
  description = "Auto Scaling Groupの最小サイズ"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Auto Scaling Groupの最大サイズ"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Auto Scaling Groupの希望サイズ"
  type        = number
  default     = 2
}

# Database関連の変数
variable "db_engine" {
  description = "データベースエンジン"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "データベースエンジンバージョン"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "RDSインスタンスクラス"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "割り当てストレージ容量(GB)"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "最大割り当てストレージ容量(GB)"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "データベース名"
  type        = string
  default     = "webappdb"
}

variable "db_username" {
  description = "データベースマスターユーザー名"
  type        = string
  default     = "admin"
}

variable "db_backup_retention_period" {
  description = "バックアップ保持期間(日)"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "バックアップウィンドウ"
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "メンテナンスウィンドウ"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "db_deletion_protection" {
  description = "削除保護"
  type        = bool
  default     = true
}

variable "db_skip_final_snapshot" {
  description = "最終スナップショットをスキップ"
  type        = bool
  default     = false
}