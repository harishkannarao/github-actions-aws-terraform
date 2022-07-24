output "s3_www_website_endpoint" {
  value = aws_s3_bucket_website_configuration.www_website.website_endpoint
}