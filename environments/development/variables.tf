variable "vpc-cidr-block" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "eu-west-2"
  description = "AWS region"
}

variable "availability-zones" {
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "public-subnet-cidr-block" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private-subnet-cidr-block" {
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "environment" {
  description = "The application environment"
}

variable "application_name" {
  description = "The name of docker application"
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

variable "image_tag" {
  description = "The docker image tag to be deployed in ecs"
}