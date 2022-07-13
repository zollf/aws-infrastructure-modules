locals {
  entry_container = var.containers[index(var.containers.*.entry_point, true)]
}

resource "aws_ecs_service" "ecs_service" {
  name                               = "ecs-service-${var.infrastructure_name}-${var.name}"
  cluster                            = data.terraform_remote_state.infra.outputs.ecs_arn
  task_definition                    = aws_ecs_task_definition.task_definition.arn
  launch_type                        = "EC2"
  desired_count                      = 1
  health_check_grace_period_seconds  = 120
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  network_configuration {
    subnets          = data.terraform_remote_state.infra.outputs.vpc_private_subnets
    assign_public_ip = false
    security_groups  = [data.terraform_remote_state.infra.outputs.ecs_security_groups]
  }

  load_balancer {
    target_group_arn = data.terraform_remote_state.infra.outputs.lb_target_group_arn
    container_name   = "${var.name}-${local.entry_container.name}"
    container_port   = local.entry_container.port
  }

  depends_on = [
    aws_ecs_task_definition.task_definition
  ]
}