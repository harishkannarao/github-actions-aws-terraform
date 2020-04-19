module "bastion" {
  source              = "../../modules/bastion"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnets_id
  availability_zones  = var.availability-zones
  ssh_public_key      = var.ssh_public_key
  security_groups_ids = [
    module.vpc.security_groups_ids,
    module.postgres-rds.db_access_sg_id,
    module.ecs.ecs_access_sg_id
  ]
}