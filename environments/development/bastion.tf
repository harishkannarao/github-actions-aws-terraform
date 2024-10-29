module "bastion" {
  source              = "../../modules/bastion"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnets_id
  ssh_key_pair_name   = var.ssh_key_pair_name
  security_groups_ids = [
    module.vpc.default_sg_id
  ]
  bastion_ingress_cidr_blocks = var.bastion_ingress_cidr_blocks
}