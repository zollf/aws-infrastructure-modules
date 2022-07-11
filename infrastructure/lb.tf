resource "aws_alb" "application_load_balancer" {
  name               = "lb-${var.name}"
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = ["${aws_security_group.lb_security_group.id}"]
  internal           = false
}

resource "aws_lb_target_group" "target_group" {
  name        = "lb-tg-${var.name}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    matcher  = "200,301,302"
    path     = "/"
    interval = 300
  }
}