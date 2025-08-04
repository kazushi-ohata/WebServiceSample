output "load_balancer_arn" {
  description = "Application Load BalancerのARN"
  value       = aws_lb.main.arn
}

output "load_balancer_dns_name" {
  description = "Application Load BalancerのDNS名"
  value       = aws_lb.main.dns_name
}

output "load_balancer_zone_id" {
  description = "Application Load BalancerのZone ID"
  value       = aws_lb.main.zone_id
}

output "target_group_arn" {
  description = "Target GroupのARN"
  value       = aws_lb_target_group.web_server.arn
}

output "autoscaling_group_name" {
  description = "Auto Scaling GroupのARN"
  value       = aws_autoscaling_group.web_server.name
}

output "autoscaling_group_arn" {
  description = "Auto Scaling GroupのARN"
  value       = aws_autoscaling_group.web_server.arn
}

output "launch_template_id" {
  description = "Launch TemplateのID"
  value       = aws_launch_template.web_server.id
}

output "web_server_security_group_id" {
  description = "WebサーバーのセキュリティグループID"
  value       = aws_security_group.web_server.id
}

output "elb_security_group_id" {
  description = "ELBのセキュリティグループID"
  value       = aws_security_group.elb.id
}