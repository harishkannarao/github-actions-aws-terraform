output "cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "service_name" {
  value = aws_ecs_service.ecs_app.name
}

output "security_group_id" {
  value = aws_security_group.ecs_security_group.id
}

output "application_log_group_name" {
  value = aws_cloudwatch_log_group.ecs_log_group.name
}

output "application_ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "application_ecs_service_name" {
  value = aws_ecs_service.ecs_app.name
}