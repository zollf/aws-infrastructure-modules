data "aws_caller_identity" "current" {
}

// Setup up ecs execution role.
// Anyone with this policy will be able to execute ecs tasks
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "iamr-ecs-exec-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_execution_policy" {
  statement {
    actions = [
      "ssm:GetParameters",
      "secretsmanager:GetSecretValue",
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/secret-${var.infrastructure_name}-${var.name}-*"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_execution_policy" {
  name = "iamr-policy-ecs-exec-ssm-${var.name}"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = data.aws_iam_policy_document.ecs_execution_policy.json
}