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

variable "public_subnet_ids" {
  description = "PublicサブネットのIDリスト"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "PrivateサブネットのIDリスト"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
}

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

variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}