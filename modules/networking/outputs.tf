output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  value       = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  description = "インターネットゲートウェイのID"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "PublicサブネットのIDリスト"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "PrivateサブネットのIDリスト"
  value       = aws_subnet.private[*].id
}

output "public_subnet_cidrs" {
  description = "PublicサブネットのCIDRブロックリスト"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_cidrs" {
  description = "PrivateサブネットのCIDRブロックリスト"
  value       = aws_subnet.private[*].cidr_block
}

output "nat_gateway_ids" {
  description = "NAT GatewayのIDリスト"
  value       = aws_nat_gateway.main[*].id
}

output "availability_zones" {
  description = "利用しているアベイラビリティゾーン"
  value       = var.availability_zones
}