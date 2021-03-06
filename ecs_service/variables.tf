variable "name" {
  description = "Name of the ecs service."
  type        = string
}

variable "region" {
  description = "Region of ecs service."
  type        = string
}

variable "infrastructure_name" {
  description = "Name of the infrastructure. Requires the use of the infrasture module."
  type        = string
}

variable "s3_remote_state_bucket" {
  description = "S3 remote state bucket name where infrastructure remote state is stored."
  type        = string
}

variable "s3_remote_state_key" {
  description = "S3 remote state bucket key where infrastructure remote state is stored."
  type        = string
}

variable "desired_count" {
  type        = number
}

variable "url" {
  type = string
}

variable "zone" {
  type = string
}

variable "containers" {
  description = "Containers for this ecs ervice."
  type = list(object({
    name                  = string
    port                  = number
    memory                = number
    cpu                   = number
    secrets               = list(string)
    environment_variables = list(string)
    entry_point           = bool
    depends               = list(string)
  }))
}

variable "environment_variables" {
  description = "Envrionment variables to be accessed by containers."
  type = list(object({
    name  = string
    value = string
  }))
}