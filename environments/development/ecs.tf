module "ecs" {
  source              = "../../modules/ecs"
  environment         = "${var.environment}"
  region              = "${var.region}"
  vpc_id              = "${module.vpc.vpc_id}"
  availability_zones  = "${var.availability-zones}"
  security_groups_ids = [
    "${module.vpc.security_groups_ids}",
    "${module.postgres-rds.db_access_sg_id}"
  ]
  subnets_ids         = "${module.vpc.private_subnets_id}"
  public_subnet_ids   = "${module.vpc.public_subnets_id}"
  database_endpoint   = "${module.postgres-rds.rds_address}"
  database_name       = "${var.database_name}"
  database_username   = "${var.database_username}"
  database_password   = "${var.database_password}"
  repository_name     = "openjobs/${var.environment}"
}