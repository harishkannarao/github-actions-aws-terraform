module "vpc" {
  source               = "../../modules/vpc"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr_block
  vpc_subnet_cidr      = var.vpc_subnet_block
}