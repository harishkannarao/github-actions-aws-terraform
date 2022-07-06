data "template_file" "www_s3_bucket_policy" {
  template = file("${path.module}/policies/public_bucket.json")

  vars = {
    www_domain_name = var.www_domain_name
  }
}

resource "aws_s3_bucket" "www" {
  bucket = var.www_domain_name
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "www_website" {
  bucket = aws_s3_bucket.www.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_acl" "www_bucket_acl" {
  bucket = aws_s3_bucket.www.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "www_bucket_policy" {
  bucket = aws_s3_bucket.www.id
  policy = data.template_file.www_s3_bucket_policy.rendered
}