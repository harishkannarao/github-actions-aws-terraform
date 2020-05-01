variable "environment" {
  description = "The environment"
}

variable "application_name" {
  description = "Application Name"
}

variable "application_log_group_name" {
  description = "Application's cloudwatch log group name"
}

variable "application_ecs_cluster_name" {
  description = "Application's ECS cluster name"
}

variable "application_ecs_service_name" {
  description = "Application's ECS service name"
}