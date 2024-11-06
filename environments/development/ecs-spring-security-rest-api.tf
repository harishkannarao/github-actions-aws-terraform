module "ecs-spring-security-rest-api" {
  source               = "../../modules/ecs"
  application_name     = var.secruity_rest_api_app_name
  image_tag            = var.secruity_rest_api_image_tag
  alb_target_group_arn = module.alb.private_alb_target_group_map["sb-sec-rest"]
  environment          = var.environment
  region               = var.region
  vpc_id               = module.vpc.vpc_id
  security_groups_ids = [
    module.alb.private_alb_security_group_id,
    module.bastion.bastion_sg_id
  ]
  subnets_ids           = module.vpc.private_subnets_id
  ecr_repository_url    = module.ecr.repository_url
  min_capacity          = var.min_capacity
  max_capacity          = var.max_capacity
  log_retention_in_days = var.log_retention_in_days
  health_check_url      = "http://localhost/spring-security-rest-api/general-data"
  env_vars = [
    {
      "name" : "SERVER_PORT",
      "value" : "80"
    },
    {
      "name" : "SSH_PUBLIC_KEY",
      "value" : module.ssh-public-key.ssh_public_key
    }
  ]
}