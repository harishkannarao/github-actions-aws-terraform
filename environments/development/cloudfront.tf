module "cloudfront" {
  source            = "../../modules/cloudfront"
  www_domain_name   = var.www_domain_name
  www_cloudfront_alias = var.www_cloudfront_alias
  s3_www_website_endpoint = module.s3.s3_www_website_endpoint
  acm_cert_domain = var.acm_cert_domain
  providers = {
    aws = aws.us_east_1
  }
}