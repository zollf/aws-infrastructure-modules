resource "aws_ecs_task_definition" "task_definition" {
  family = "ecs-task-${var.infrastructure_name}-${var.name}"
  container_definitions = <<EOL
    ${jsonencode([
      for index, container in var.containers : {
        "name": "${var.name}-${container.name}",
        "image": "${aws_ecr_repository.repositories[container.name].repository_url}",
        "cpu": container.cpu,
        "memory": container.memory,
        "portMappings": [
          {
            "containerPort": container.port,
            "hostPort": container.port,
            "protocol": "tcp"
          }
        ],
        "environment": [for env in var.environment_variables : {
          "name": "${env.name}",
          "value": "${env.value}"
        } if contains(container.environment_variables, env.name)],
        "secrets": [for secret in container.secrets : {
          "name": "${secret}",
          "valueFrom": "secret-${var.infrastructure_name}-${var.name}-${secret}"
        }],
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.logs.name}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "dependsOn": [for depend in container.depends : {
          "containerName": "${var.name}-${depend}",
          "condition": "START"
        }]
      }
    ])}
  EOL

  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  memory                   = sum([for container in var.containers : container.memory])
  cpu                      = sum([for container in var.containers : container.cpu])
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  depends_on = [
    aws_ecr_repository.repositories,
    aws_cloudwatch_log_group.logs,
    aws_ssm_parameter.secrets
  ]
}