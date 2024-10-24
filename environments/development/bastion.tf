module "bastion" {
  source              = "../../modules/bastion"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnets_id
  ssh_key_pair_name   = var.ssh_key_pair_name
  security_groups_ids = [
    module.vpc.default_sg_id,
    module.postgres-rds.db_access_sg_id,
    module.ecs.security_group_id,
    module.alb.public_alb_security_group_id,
    module.alb.private_alb_security_group_id
  ]
}