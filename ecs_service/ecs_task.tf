resource "aws_ecs_task_definition" "task_definition" {
  family = "ecs-task-${var.infrastructure_name}-${var.name}"
  container_definitions = <<EOL
  ${jsonencode([

])}
  EOL
requires_compatibilities = ["EC2"]
network_mode             = "awsvpc"
memory                   = 512
cpu                      = 256
execution_role_arn       = "arn:aws:iam::703161335764:role/main-cluster-ecs-task-execution-role"
}