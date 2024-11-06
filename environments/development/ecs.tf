module "ecs" {
  source               = "../../modules/ecs"
  application_name     = var.application_name
  image_tag            = var.image_tag
  alb_target_group_arn = module.alb.public_alb_default_target_group_arn
  environment          = var.environment
  region               = var.region
  vpc_id               = module.vpc.vpc_id
  security_groups_ids = [
    module.postgres-rds.db_access_sg_id,
    module.alb.public_alb_security_group_id,
    module.alb.private_alb_security_group_id,
    module.bastion.bastion_sg_id
  ]
  subnets_ids           = module.vpc.private_subnets_id
  ecr_repository_url    = module.ecr.repository_url
  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  log_retention_in_days = var.log_retention_in_days
  health_check_url      = "http://localhost/health-check"
  env_vars = [
    {
      "name" : "SERVER_PORT",
      "value" : "80"
    },
    {
      "name" : "APP_DATASOURCE_HIKARI_JDBC_URL",
      "value" : "jdbc:postgresql://${module.postgres-rds.rds_address}:5432/${var.database_name}"
    },
    {
      "name" : "APP_DATASOURCE_HIKARI_USERNAME",
      "value" : var.database_username
    },
    {
      "name" : "APP_DATASOURCE_HIKARI_PASSWORD",
      "value" : module.postgres-rds.rds_database_password
    },
    {
      "name" : "THIRDPARTY_PING_URL",
      "value" : var.third_party_ping_url
    },
    {
      "name" : "THIRDPARTY_PROXY_URL",
      "value" : var.third_party_proxy_url
    },
    {
      "name" : "SSH_PUBLIC_KEY",
      "value" : module.ssh-public-key.ssh_public_key
    },
    {
      "name" : "APP_CORS_ORIGINS",
      "value" : var.app_cors_origins
    },
    {
      "name" : "APP_OPENAPI_URL",
      "value" : var.app_openapi_url
    }
  ]
}