resource "aws_ecs_cluster" "cluster" {
  name = "ecs-${var.region}-${var.name}"

  tags = {
    Name      = "${var.name}"
    Terraform = "True"
  }
}