module "s3" {
  source            = "../../modules/s3"
  www_domain_name   = var.www_domain_name
}