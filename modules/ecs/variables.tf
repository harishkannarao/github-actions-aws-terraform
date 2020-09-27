variable "environment" {
  description = "The environment"
}

variable "application_name" {
  description = "Application Name"
}

variable "acm_cert_domain" {
  description = "The domain name used in AWS Certificate Manager"
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

variable "public_subnet_ids" {
  description = "The public subnets to use"
}

variable "database_endpoint" {
  description = "The database endpoint"
}

variable "database_username" {
  description = "The database username"
}

variable "database_password" {
  description = "The database password"
}

variable "database_name" {
  description = "The database that the app will use"
}

variable "repository_name" {
  description = "The name of the repisitory"
}

variable "third_party_ping_url" {
  description = "The third party url to ping"
}

variable "ssh_public_key" {
  description = "SSH public key for Fargate containers"
}

variable "log_retention_in_days" {
  description = "No of days to retain logs"
}

variable "app_cors_origins" {
  description = "Comma separated values of permittied origins allowed for CORS"
}

variable "app_openapi_url" {
  description = "Comma separated values of permittied origins allowed for CORS"
}