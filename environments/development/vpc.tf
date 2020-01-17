module "vpc" {
  source               = "../../modules/vpc"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc-cidr-block}"
  public_subnets_cidr  = "${var.public-subnet-cidr-block}"
  private_subnets_cidr = "${var.private-subnet-cidr-block}"
  availability_zones   = "${var.availability-zones}"
}