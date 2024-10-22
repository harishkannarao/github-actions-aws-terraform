data "template_file" "www_s3_bucket_policy" {
  template = file("${path.module}/policies/public_bucket.json")

  vars = {
    bucket_name = var.bucket_name
  }
}

resource "aws_s3_bucket" "www" {
  bucket = var.bucket_name
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

resource "aws_s3_bucket_public_access_block" "www_bucket_public_access_block" {
  bucket = aws_s3_bucket.www.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "www_bucket_acl_ownership" {
  bucket = aws_s3_bucket.www.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.www_bucket_public_access_block]
}

resource "aws_s3_bucket_acl" "www_bucket_act" {
    bucket = aws_s3_bucket.www.id
    acl    = "public-read"
    depends_on = [aws_s3_bucket_ownership_controls.www_bucket_acl_ownership]
}


resource "aws_s3_bucket_policy" "www_bucket_policy" {
  bucket = aws_s3_bucket.www.id
  policy = data.template_file.www_s3_bucket_policy.rendered
  depends_on = [aws_s3_bucket_public_access_block.www_bucket_public_access_block]
}