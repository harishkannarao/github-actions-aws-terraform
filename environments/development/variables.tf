variable "vpc_cidr_block" {
  description = "VPC cidr block"
}

variable "vpc_subnet_block" {
  description = "VPC subnet block"
}

variable "region" {
  description = "AWS region"
}

variable "environment" {
  description = "The application environment"
}

variable "ssh_key_pair_name" {
  description = "SSH key pair name"
}

variable "application_name" {
  description = "The name of docker application"
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

variable "database_name" {
  description = "The database name"
}

variable "database_username" {
  description = "The username for the database"
}

variable "database_multi_az" {
  description = "The user password for the database"
}

variable "third_party_ping_url" {
  description = "The third party url to ping"
}

variable "third_party_proxy_url" {
  description = "The third proxy url to get"
}

variable "image_tag" {
  description = "The docker image tag to be deployed in ecs"
}

variable "log_retention_in_days" {
  description = "No of days to retain logs"
}

variable "app_cors_origins" {
  description = "Comma separated values of permittied origins allowed for CORS"
}

variable "app_openapi_url" {
  description = "Open API url for Swagger configuration"
}

variable "www_domain_name" {
  description = "Domain name to access front end website"
}

variable "www_cloudfront_alias" {
  description = "Cloudfront alias"
}

variable "secruity_rest_api_app_name" {
  description = "Name for Spring Boot Security Rest API"
}

variable "secruity_rest_api_image_tag" {
  description = "Image tag for Spring Boot Security Rest API"
}

variable "public_alb_path_mappings" {
  description = "Path mappings for public alb"
  type = map(object({
    priority          = number
    path_pattern      = string
    port              = number
    protocol          = string
    health_check_path = string
  }))
}

variable "private_alb_path_mappings" {
  description = "Path mappings for private alb"
  type = map(object({
    priority          = number
    path_pattern      = string
    port              = number
    protocol          = string
    health_check_path = string
  }))
}

variable "bastion_ingress_cidr_blocks" {
  description = "CIDR blocks for bastion ingress rule. Usually the cidr blocks for office IPs or VPN servers"
  type = set(string)
}