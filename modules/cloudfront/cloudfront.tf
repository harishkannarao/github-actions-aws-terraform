terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

/*====
Get latest AWS certificate for the domain
======*/
data "aws_acm_certificate" "default" {
  domain      = var.acm_cert_domain
  statuses = ["ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "www_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.www_cloudfront_alias]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.default.arn
    ssl_support_method  = "sni-only"
  }

  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = var.s3_www_website_endpoint
    origin_id   = var.s3_www_origin_id
  }


  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id       = var.s3_www_origin_id
    min_ttl                = 0
    default_ttl            = 120
    max_ttl                = 600

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  # Secondary origin with path-pattern based cache behavior
  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    domain_name = var.s3_www_beta_website_endpoint
    origin_id   = var.s3_www_beta_origin_id
  }

  ordered_cache_behavior {
    path_pattern           = "/beta/*"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id       = var.s3_www_beta_origin_id
    min_ttl                = 0
    default_ttl            = 120
    max_ttl                = 600

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

}