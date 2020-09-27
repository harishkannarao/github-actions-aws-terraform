module "ecs" {
  source              = "../../modules/ecs"
  application_name    = var.application_name
  environment         = var.environment
  acm_cert_domain     = var.acm_cert_domain
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  security_groups_ids = [
    module.vpc.security_groups_ids,
    module.postgres-rds.db_access_sg_id
  ]
  subnets_ids         = module.vpc.private_subnets_id
  public_subnet_ids   = module.vpc.public_subnets_id
  database_endpoint   = module.postgres-rds.rds_address
  database_name       = var.database_name
  database_username   = var.database_username
  database_password   = var.database_password
  repository_name     = "${var.application_name}/${var.environment}"
  third_party_ping_url = var.third_party_ping_url
  image_tag           = var.image_tag
  min_capacity        = var.min_capacity
  max_capacity        = var.max_capacity
  ssh_public_key      = var.ssh_public_key
  log_retention_in_days = var.log_retention_in_days
  app_cors_origins    = var.app_cors_origins
  app_openapi_url     = var.app_openapi_url
}