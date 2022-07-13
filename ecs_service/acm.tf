data "aws_route53_zone" "zone" {
  name  = "${var.zone}"
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name  = "${var.url}"
  zone_id      = data.aws_route53_zone.zone.zone_id

  wait_for_validation = false

  tags = {
    Infra = "${var.infrastructure_name}"
    Terraform = "True"
    Name = "${var.url}"
  }
}
