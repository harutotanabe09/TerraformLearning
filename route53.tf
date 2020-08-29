resource "aws_route53_zone" "site_zone" {
  name = "example2222.com"
}

resource "aws_route53_zone" "saws_route53_zonete_zone" {
  name = var.root_domain
  tags = {
    Environment = terraform.workspace,
    AppName     = local.name
  }
}

resource "aws_route53_record" "site" {
  zone_id = aws_route53_zone.site_zone.zone_id
  name    = var.site_domain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}