module "bastion" {
  source              = "../../modules/bastion"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnets_id
  ssh_key_pair_name   = var.ssh_key_pair_name
  security_groups_ids = [
    module.vpc.security_groups_ids,
    module.postgres-rds.db_access_sg_id,
    module.ecs.security_group_id
  ]
}