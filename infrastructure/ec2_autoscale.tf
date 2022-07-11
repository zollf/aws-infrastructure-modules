resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  name                 = "asg-ecs-${var.name}"
  max_size             = var.max_autoscale_size
  min_size             = var.min_autoscale_size
  desired_capacity     = var.desired_autoscale_size
  vpc_zone_identifier  = module.vpc.private_subnets
  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.ecs_launch_configuration.name
  depends_on           = [aws_launch_configuration.ecs_launch_configuration]

  tag {
    key                 = "Name"
    value               = aws_ecs_cluster.cluster.name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_security_group" "ecs" {
  name        = "seg-ecs-${var.name}"
  description = "Security group for ecs ${var.name}"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc_ssh_access.id]
  }

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Infra     = "${var.name}"
    Terraform = "True"
  }
}