variable "environment" {
  description = "The environment"
}

variable "availability_zones" {
  type        = list(string)
  description = "The az that the resources will be launched"
}

variable "ssh_public_key" {
  description = "SSH public key"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "security_groups_ids" {
  description = "The SGs to use"
}