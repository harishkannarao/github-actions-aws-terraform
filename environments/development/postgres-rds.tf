module "postgres-rds" {
  source            = "../../modules/postgres-rds"
  environment       = var.environment
  allocated_storage = "5"
  database_name     = var.database_name
  database_username = var.database_username
  subnet_ids        = module.vpc.private_subnets_id
  vpc_id            = module.vpc.vpc_id
  instance_class    = "db.t4g.medium"
  multi_az          = var.database_multi_az
  security_groups_ids = [
    module.bastion.bastion_sg_id
  ]
}