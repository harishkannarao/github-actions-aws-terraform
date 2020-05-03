module "cloudwatch" {
  source              = "../../modules/cloudwatch"
  application_name    = var.application_name
  environment         = var.environment
  application_log_group_name = module.ecs.application_log_group_name
  application_ecs_cluster_name = module.ecs.application_ecs_cluster_name
  application_ecs_service_name = module.ecs.application_ecs_service_name
  ecs_min_task_count = var.min_capacity
  rds_database_identifier = module.postgres-rds.rds_database_identifier
}