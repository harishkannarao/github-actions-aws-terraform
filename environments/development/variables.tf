variable "vpc-cidr-block" {
  description = "VPC cidr block"
}

variable "region" {
  description = "AWS region"
}

variable "availability-zones" {
  description = "AWS region's availability zones"
}

variable "public-subnet-cidr-block" {
  description = "Public Subnet cidr block"
}

variable "private-subnet-cidr-block" {
  description = "Private Subnet cidr block"
}

variable "environment" {
  description = "The application environment"
}

variable "ssh_key_pair_name" {
  description = "SSH key pair name"
}

variable "ssh_public_key" {
  description = "SSH public key for fargate containers"
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

variable "database_password" {
  description = "The user password for the database"
}

variable "database_multi_az" {
  description = "The user password for the database"
}

variable "third_party_ping_url" {
  description = "The third party url to ping"
}

variable "image_tag" {
  description = "The docker image tag to be deployed in ecs"
}

variable "log_retention_in_days" {
  description = "No of days to retain logs"
}