# VPC関連の出力
output "vpc_id" {
  description = "VPCのID"
  value       = module.networking.vpc_id
}

output "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  value       = module.networking.vpc_cidr_block
}

# サブネット関連の出力
output "public_subnet_ids" {
  description = "PublicサブネットのIDリスト"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "PrivateサブネットのIDリスト"
  value       = module.networking.private_subnet_ids
}

# ネットワーク関連の出力
output "internet_gateway_id" {
  description = "インターネットゲートウェイのID"
  value       = module.networking.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "NAT GatewayのIDリスト"
  value       = module.networking.nat_gateway_ids
}

output "availability_zones" {
  description = "利用しているアベイラビリティゾーン"
  value       = module.networking.availability_zones
}

# Compute関連の出力
output "load_balancer_dns_name" {
  description = "Application Load BalancerのDNS名"
  value       = module.compute.load_balancer_dns_name
}

output "load_balancer_arn" {
  description = "Application Load BalancerのARN"
  value       = module.compute.load_balancer_arn
}

output "target_group_arn" {
  description = "Target GroupのARN"
  value       = module.compute.target_group_arn
}

output "autoscaling_group_name" {
  description = "Auto Scaling Groupの名前"
  value       = module.compute.autoscaling_group_name
}

output "web_server_security_group_id" {
  description = "WebサーバーのセキュリティグループID"
  value       = module.compute.web_server_security_group_id
}

output "elb_security_group_id" {
  description = "ELBのセキュリティグループID"
  value       = module.compute.elb_security_group_id
}

# Database関連の出力
output "db_instance_endpoint" {
  description = "RDS エンドポイント"
  value       = module.database.db_instance_endpoint
}

output "db_instance_id" {
  description = "RDS インスタンスID"
  value       = module.database.db_instance_id
}

output "db_instance_arn" {
  description = "RDS インスタンスARN"
  value       = module.database.db_instance_arn
}

output "db_security_group_id" {
  description = "RDS セキュリティグループID"
  value       = module.database.db_security_group_id
}

output "secrets_manager_secret_arn" {
  description = "Secrets Manager シークレットARN"
  value       = module.database.secrets_manager_secret_arn
}

output "db_name" {
  description = "データベース名"
  value       = module.database.db_name
}