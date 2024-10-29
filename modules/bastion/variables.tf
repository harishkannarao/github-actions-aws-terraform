variable "environment" {
  description = "The environment"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "security_groups_ids" {
  description = "The SGs to use"
}

variable "public_subnet_ids" {
  description = "The public subnets to use"
}

variable "ssh_key_pair_name" {
  description = "SSH keypair to use"
}

variable "bastion_ingress_cidr_blocks" {
  description = "CIDR blocks for bastion ingress rule. Usually the cidr blocks for office IPs or VPN servers"
  type = set(string)
}