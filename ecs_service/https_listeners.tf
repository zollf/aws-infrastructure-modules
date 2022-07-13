
resource "aws_lb_listener" "https" {
  load_balancer_arn = data.terraform_remote_state.infra.outputs.lb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = module.acm.acm_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      status_code  = 503
      content_type = "text/plain"
    }
  }
}

resource "aws_lb_listener_rule" "https" {
  listener_arn = aws_lb_listener.https.arn

  action {
    type             = "forward"
    target_group_arn = data.terraform_remote_state.infra.outputs.lb_target_group_arn
  }

  condition {
    host_header {
      values = ["${var.url}"]
    }
  }
}