variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名 (prd, dev, etc.)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "PrivateサブネットのIDリスト"
  type        = list(string)
}

variable "web_server_security_group_id" {
  description = "WebサーバーのセキュリティグループID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "engine" {
  description = "データベースエンジン"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "データベースエンジンバージョン"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "RDSインスタンスクラス"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "割り当てストレージ容量(GB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
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

variable "backup_retention_period" {
  description = "バックアップ保持期間(日)"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "バックアップウィンドウ"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "メンテナンスウィンドウ"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "deletion_protection" {
  description = "削除保護"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "最終スナップショットをスキップ"
  type        = bool
  default     = false
}

variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}
