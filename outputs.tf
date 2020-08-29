# ---------------
# output.tf
# ---------------

# Name Servers
output "zone_name_servers" {
  value = aws_route53_zone.site_zone.name_servers
}

# CloudFront Destributionの出力
output "cloud_front_destribution_domain_name" {
  value = aws_cloudfront_distribution.cf.domain_name
}