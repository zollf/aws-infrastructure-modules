locals {
  images_to_create = [for container in var.containers : container.name]
}

resource "aws_ecr_repository" "repositories" {
  for_each = toset(local.images_to_create)
  name     = "ecr-${var.infrastructure_name}-${var.name}-${each.key}"
}