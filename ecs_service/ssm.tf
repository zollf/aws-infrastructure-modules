resource "aws_ssm_parameter" "secrets" {
  for_each  = toset(var.secrets)
  name      = "ssm-${var.infrastructure_name}-${var.name}-${each.key}"
  type      = "SecureString"
  value     = "default"
  overwrite = true

  tags = {
    Infra     = "${var.infrastructure_name}"
    terraform = "True"
  }

  lifecycle {
    ignore_changes = [value]
  }
}