module "s3" {
  source            = "../../modules/s3"
  region            = var.region
  www_domain_name   = var.www_domain_name
}