output "vpc_private_subnets" {
  description = "List of IDs of private subnets."
  value = module.vpc.private_subnets
}

output "ecs_security_groups" {
  description = "ECS security group id."
  value       = aws_security_group.service_security_group.id
}

output "ecs_arn" {
  description = "ECS arn."
  value       = aws_ecs_cluster.cluster.arn
}

output "lb_target_group_arn" {
  description = "Load balancer target group arn."
  value       = aws_lb_target_group.target_group.arn
}

output "lb_arn" {
  description = "Load balancer arn."
  value       = aws_alb.application_load_balancer.arn
}
