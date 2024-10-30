variable "environment" {
  description = "The environment"
}

variable "application_name" {
  description = "Application Name"
}

variable "min_capacity" {
  description = "Mininum number of nodes"
}

variable "max_capacity" {
  description = "Maximum number of nodes"
}

variable "region" {
}

variable "image_tag" {
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "security_groups_ids" {
  description = "The SGs to use"
}

variable "subnets_ids" {
  description = "The private subnets to use"
}

variable "ecr_repository_url" {
  description = "The ecr repository url to pull docker image"
}

variable "log_retention_in_days" {
  description = "No of days to retain logs"
}

variable "alb_target_group_arn" {
  description = "ALB target group arn for load balancing"
}

variable "env_vars" {
  description = "Environment Variables to be passed to the docker container"
}

variable "health_check_url" {
  description = "Health Check url for the container"
}