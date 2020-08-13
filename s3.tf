resource "aws_s3_bucket" "s3" {
  # バケット名
  bucket        = "ap-northeast-1-cloudfront-resource-demo-2020813"
  acl           = "public-read"
  force_destroy = true
  website {
    index_document = "index.html"
  }
}