module "cloudwatch" {
  source              = "../../modules/cloudwatch"
  application_name    = var.application_name
  environment         = var.environment
}