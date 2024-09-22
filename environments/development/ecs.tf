module "ecs" {
  source              = "../../modules/ecs"
  application_name    = var.application_name
  environment         = var.environment
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  security_groups_ids = [
    module.vpc.security_groups_ids,
    module.postgres-rds.db_access_sg_id,
    module.alb.public_alb_security_group_id,
    module.alb.private_alb_security_group_id
  ]
  public_alb_default_target_group_arn = module.alb.public_alb_default_target_group_arn
  subnets_ids         = module.vpc.private_subnets_id
  database_endpoint   = module.postgres-rds.rds_address
  database_name       = var.database_name
  database_username   = var.database_username
  database_password   = module.postgres-rds.rds_database_password
  ecr_repository_url  = module.ecr.repository_url
  third_party_ping_url = var.third_party_ping_url
  third_party_proxy_url = var.third_party_proxy_url
  image_tag           = var.image_tag
  min_capacity        = var.min_capacity
  max_capacity        = var.max_capacity
  ssh_public_key      = var.ssh_public_key
  log_retention_in_days = var.log_retention_in_days
  app_cors_origins    = var.app_cors_origins
  app_openapi_url     = var.app_openapi_url
}