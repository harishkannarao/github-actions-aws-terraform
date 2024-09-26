module "ecs-spring-security-rest-api" {
  source              = "../../modules/ecs-spring-security-rest-api"
  application_name    = var.secruity_rest_api_app_name
  image_tag           = var.secruity_rest_api_image_tag
  environment         = var.environment
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  security_groups_ids = [
    module.vpc.security_groups_ids,
    module.alb.private_alb_security_group_id
  ]
  alb_target_group_arn = module.alb.private_springboot_security_rest_api_target_group
  subnets_ids         = module.vpc.private_subnets_id
  ecr_repository_url  = module.ecr.repository_url
  min_capacity        = var.min_capacity
  max_capacity        = var.max_capacity
  ssh_public_key      = var.ssh_public_key
  log_retention_in_days = var.log_retention_in_days
}