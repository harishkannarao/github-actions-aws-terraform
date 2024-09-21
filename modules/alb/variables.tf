variable "environment" {
  description = "The environment"
}

variable "application_name" {
  description = "Application Name"
}

variable "acm_cert_domain" {
  description = "The domain name used in AWS Certificate Manager"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "public_subnet_ids" {
  description = "The public subnets to use"
}

variable "subnets_ids" {
  description = "The private subnets to use"
}

variable "public_alb_security_groups_ids" {
  description = "The SGs to use for public ALB"
}

variable "private_alb_security_groups_ids" {
  description = "The SGs to use for private ALB"
}