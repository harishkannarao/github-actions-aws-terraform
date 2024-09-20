module "ecr" {
  source              = "../../modules/ecr"
  repository_name     = "${var.application_name}/${var.environment}"
}