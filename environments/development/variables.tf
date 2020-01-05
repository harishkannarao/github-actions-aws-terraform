variable "region" {
  default = "eu-west-2"
}

variable "availability-zones" {
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "vpc-cidr-block" {
  default = "10.0.0.0/16"
}

variable "public-subnet-cidr-block" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private-subnet-cidr-block" {
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "environment" {
  default = "development"
}
