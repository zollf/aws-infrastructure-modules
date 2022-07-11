resource "aws_eip" "nat" {
  count = 1

  vpc = true
}

module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "3.12.0"
  name                = "vpc-${var.region}-${var.name}"
  cidr                = "10.0.0.0/16"
  azs                 = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway  = true
  single_nat_gateway  = true
  enable_vpn_gateway  = true
  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.nat.*.id

  tags = {
    Infra     = "${var.name}"
    Terraform = "True"
  }
}