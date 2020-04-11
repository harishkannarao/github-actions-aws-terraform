variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "The CIDR block for the private subnet"
}

variable "environment" {
  description = "The environment"
}

variable "availability_zones" {
  type        = list(string)
  description = "The az that the resources will be launched"
}