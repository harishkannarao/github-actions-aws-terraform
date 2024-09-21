output "public_alb_security_group_id" {
  value = aws_security_group.docker_http_app_inbound_sg.id
}

output "private_alb_security_group_id" {
  value = aws_security_group.private_inbound_sg.id
}

output "public_alb_default_target_group_arn" {
  value = aws_alb_target_group.docker_http_app_alb_target_group.arn
}

output "alb_dns_name" {
  value = aws_alb.docker_http_app.dns_name
}

output "alb_zone_id" {
  value = aws_alb.docker_http_app.zone_id
}

output "private_alb_dns_name" {
  value = aws_alb.private_alb.dns_name
}

output "private_alb_zone_id" {
  value = aws_alb.private_alb.zone_id
}