resource "aws_ecs_cluster" "cluster" {
  name = "ecs-${var.region}-${var.name}"

  tags = {
    Infra     = "${var.name}"
    Terraform = "True"
  }
}