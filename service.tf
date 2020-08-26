# Local Variable
locals {
  name = format("%s-%s", var.name, terraform.workspace)
}

# Cloudfront Identity
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = var.name
}

# S3 Bucket
resource "aws_s3_bucket" "s3" {
  bucket = local.name
  # ACL:外部公開の設定OFF
  acl = var.acl
  # 空でないバケットの削除を許可
  force_destroy = true
  # バケットポリシー：CloudFrontを設定
  policy = templatefile("policy.json.tmpl", { origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.id, bucket_name = format("%s-%s", var.name, terraform.workspace) })
  # CORS設定:JS対応
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    # TODO:ドメイン指定
    allowed_origins = ["*"]
    expose_headers  = ["HEAD"]
    max_age_seconds = 3000
  }
}

# Cloudfront
resource "aws_cloudfront_distribution" "cf" {
  enabled             = true
  comment             = local.name
  default_root_object = var.index
  price_class         = "PriceClass_200"
  retain_on_delete    = true
  # キャッシュ元の設定
  origin {
    # S3のドメイン設定 : リージョン指定しないとCloudFrontへリダイレクトする場合あり
    domain_name = format("%s.s3-%s.amazonaws.com", aws_s3_bucket.s3.id, var.region)
    origin_id   = local.name
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3.id
    forwarded_values {
      #クエリ文字列を転送
      query_string = false
      #クッキーの転送
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
    #アクセスを制限したい地域の設定
    geo_restriction {
      restriction_type = "none"
    }
  }
  tags = {
    Environment = terraform.workspace,
    AppName     = local.name
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}