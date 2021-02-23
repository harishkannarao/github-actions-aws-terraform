data "template_file" "www_s3_bucket_policy" {
  template = file("${path.module}/policies/public_bucket.json")

  vars = {
    www_domain_name = var.www_domain_name
  }
}

resource "aws_s3_bucket" "www" {
  bucket = var.www_domain_name
  acl    = "public-read"
  policy = data.template_file.www_s3_bucket_policy.rendered
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}