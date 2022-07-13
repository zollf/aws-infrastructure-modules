resource "aws_cloudwatch_log_group" "logs" {
  name              = "cw-${var.infrastructure_name}-${var.name}"
  retention_in_days = 7
}