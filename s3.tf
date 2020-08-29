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