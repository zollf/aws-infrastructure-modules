variable "name" {
  description = "Name of the aws infrastructure."
  type        = string
}

variable "region" {
  description = "AWS Region."
  type        = string
  default     = "ap-southeast-2"
}

variable "max_autoscale_size" {
  description = "Maximum ec2 instances within autoscale group."
  type        = number
}

variable "min_autoscale_size" {
  description = "Minimum ec2 instances within autoscale group."
  type        = number
}

variable "desired_autoscale_size" {
  description = "Desired ec2 instances within autoscale group."
  type        = number
}

variable "ec2_instance_size" {
  description = "EC2 instance size."
  type        = string
  default     = "t3.micro"
}

variable "rds_password" {
  description = "Password for RDS."
  type        = string
}