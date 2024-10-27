output "public_alb_security_group_id" {
  value = aws_security_group.public_alb_inbound_sg.id
}

output "private_alb_security_group_id" {
  value = aws_security_group.private_inbound_sg.id
}

output "public_alb_default_target_group_arn" {
  value = aws_alb_target_group.public_alb_default_target_group.arn
}

output "public_alb_target_group_map" {
  value = {
    for k, v in var.public_alb_path_mappings : k => aws_alb_target_group.public_alb_target_group_mapping[k].arn
  }
}

output "private_alb_target_group_map" {
  value = {
    for k, v in var.private_alb_path_mappings : k => aws_alb_target_group.private_alb_target_group_mapping[k].arn
  }
}

output "alb_dns_name" {
  value = aws_alb.public_alb.dns_name
}

output "alb_zone_id" {
  value = aws_alb.public_alb.zone_id
}

output "private_alb_dns_name" {
  value = aws_alb.private_alb.dns_name
}

output "private_alb_zone_id" {
  value = aws_alb.private_alb.zone_id
}