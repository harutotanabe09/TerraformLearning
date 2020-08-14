# Variable list
variable "name" { default = "enjapan-service-storage-develop-20100010"}
variable "acl" { default = "public-read" }
variable "index" { default = "index.html" }
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = var.name
}
# S3 Bucket
resource "aws_s3_bucket" "s3" {
  bucket        = var.name
  acl           = var.acl
  force_destroy = true
  policy = templatefile("policy.json.tmpl", { origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.id , bucket_name = var.name })
  website {
    index_document = var.index
  }
}
# Cloudfront
resource "aws_cloudfront_distribution" "cf" {
  enabled             = true
  comment             = var.name
  default_root_object = var.index
  price_class         = "PriceClass_200"
  retain_on_delete    = true
  origin {
    domain_name = format("%s.s3.amazonaws.com", aws_s3_bucket.s3.id)
    origin_id   = var.name
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3.id
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "JP"]
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}