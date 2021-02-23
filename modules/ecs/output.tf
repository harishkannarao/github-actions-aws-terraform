output "registry_id" {
  value = aws_ecr_repository.docker_http_app.registry_id
}

output "repository_url" {
  value = aws_ecr_repository.docker_http_app.repository_url
}

output "cluster_name" {
  value = aws_ecs_cluster.docker_http_app_cluster.name
}

output "service_name" {
  value = aws_ecs_service.docker_http_app.name
}

output "alb_dns_name" {
  value = aws_alb.docker_http_app.dns_name
}

output "alb_zone_id" {
  value = aws_alb.docker_http_app.zone_id
}

output "security_group_id" {
  value = aws_security_group.docker_http_app_ecs_service.id
}

output "app_inbound_security_group_id" {
  value = aws_security_group.docker_http_app_inbound_sg.id
}

output "application_log_group_name" {
  value = aws_cloudwatch_log_group.docker_http_app.name
}

output "application_ecs_cluster_name" {
  value = aws_ecs_cluster.docker_http_app_cluster.name
}

output "application_ecs_service_name" {
  value = aws_ecs_service.docker_http_app.name
}