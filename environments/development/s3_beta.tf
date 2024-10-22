module "s3_beta" {
  source            = "../../modules/s3"
  bucket_name   = "beta-${var.www_domain_name}"
}