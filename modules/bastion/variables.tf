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

variable "bastion_ingress_rules" {
  description = "Ingress rules for bastion server"
  type = map(object({
    cidr_ipv4   = string
    ip_protocol = string
    from_port   = number
    to_port     = number
  }))
}