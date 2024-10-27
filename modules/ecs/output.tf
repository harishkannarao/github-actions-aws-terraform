output "cluster_name" {
  value = aws_ecs_cluster.app_cluster.name
}

output "service_name" {
  value = aws_ecs_service.app.name
}

output "security_group_id" {
  value = aws_security_group.app_ecs_service.id
}

output "application_log_group_name" {
  value = aws_cloudwatch_log_group.app.name
}

output "application_ecs_cluster_name" {
  value = aws_ecs_cluster.app_cluster.name
}

output "application_ecs_service_name" {
  value = aws_ecs_service.app.name
}