module "s3" {
  source            = "../../modules/s3"
  bucket_name   = var.www_domain_name
}