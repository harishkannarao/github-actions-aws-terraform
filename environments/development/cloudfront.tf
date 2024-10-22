module "cloudfront" {
  source            = "../../modules/cloudfront"
  s3_www_origin_id   = var.www_domain_name
  s3_www_beta_origin_id = "beta-${var.www_domain_name}"
  s3_www_website_endpoint = module.s3.s3_www_website_endpoint
  s3_www_beta_website_endpoint = module.s3_beta.s3_www_website_endpoint
  www_cloudfront_alias = var.www_cloudfront_alias
  acm_cert_domain = var.acm_cert_domain
  providers = {
    aws = aws.us_east_1
  }
}