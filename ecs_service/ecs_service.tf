locals {
  entry_container = var.containers[index(var.containers.*.entry_point, true)]
}

resource "aws_ecs_service" "ecs_service" {
  name                               = "ecs-service-${var.infrastructure_name}-${var.name}"
  cluster                            = data.remote_state.infra.outputs.ecs_arn
  task_definition                    = "arn:aws:ecs:ap-southeast-2:703161335764:task-definition/dylankio_task"
  launch_type                        = "EC2"
  desired_count                      = 1
  health_check_grace_period_seconds  = 120
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  network_configuration {
    subnets          = data.remote_state.infra.outputs.vpc_private_subnets
    assign_public_ip = true
    security_groups  = [data.remote_state.infra.outputs.ecs_security_groups]
  }

  load_balancer {
    target_group_arn = data.remote_state.infra.outputs.lb_target_group_arn
    container_name   = local.entry_container.name
    container_port   = local.entry_container.port
  }
}