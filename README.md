# AWS Infrastructure modules
My aws infrastructure modules.

## Naming Conventions
| Resource              | Naming Convention                   |
| --------------------- | ----------------------------------- |
| VPC                   | `vpc-<region>-<name>`               |
| ECS                   | `ecs-<region>-<name>`               |
| ECS TASK DEFINITION   | `ecs-task-<infra>-<name>`           |
| ECS SERVICE           | `ecs-service-<infra>-<name>`        |
| AUTO-SCALE GROUP      | `asg-<resource>-<name>`             |   
| SECURITY GROUP        | `seg-<resource>-<name>`             | 
| LAUNCH CONFIG         | `lc-<resource>-<name>`              |
| KEY PAIR              | `key-<name>`                        |
| IAM ROLE              | `iamr-<resource>-<name>`            |
| IAM ROLE POLICY       | `iamr-policy-<resource>-<name>`     |
| IAM USER              | `iamu-<resource>-<name>`            |
| IAM USER POLICY       | `iamu-policy-<resource>-<name>`     |
| IAM USER GROUP        | `iamug-<resource>-<name>`           |
| IAM USER GROUP POLICY | `iamug-policy-<resource>-<name>`    |
| IAM INSTANCE PROFILE  | `iam-instance-<resource>-<name>`    |
| LB                    | `lb-<name>`                         |
| LB TARGET GROUP       | `lb-tg-<name>`                      |
| RDS                   | `rds-<engine>-<name>`               |
| EC2                   | `ec2-<resource>-<name>`             |
| SSM                   | `ssm-<infra>-<resource>-<name>`     |
| ECR                   | `ecr-<infra>-<resource>-<name>`     |
| CLOUDWATCH            | `cw-<infra>-<name>`                 |

## Infrastructure Module

Creates:
- ECS 
- VPC for your ECS and resources to live in
- LB for your ECS
- EC2 instances for your ECS
- RDS for your ECS
- EC2 SSH instance to access vpc
- Security and target groups for ECS and VPC communication

### Examples:
```terraform
module "infrastructure" {
  source                 = "../aws-infrastructure-modules/infrastructure"
  name                   = "core"
  region                 = "ap-southeast-2"
  max_autoscale_size     = 2
  min_autoscale_size     = 1
  desired_autoscale_size = 1
  ec2_instance_size      = "t3.micro"
  rds_password           = "my_secret_password"
}
```

## ECS Service Module

Creates:
- ECS task definition for your containers
- ECS service for your application

### Examples:
```terraform
module "dylank" {
  source = "../../aws-infrastructure-modules/ecs_service"
  name = "dylank"
  region = "ap-southeast-2"
  infrastructure_name = "core"
  s3_remote_state_bucket = "s3-tf-remote-state"
  s3_remote_state_key = "infrastructure/infra.tfstate"
  desired_count = 0
  url = "dylank.io"
  zone = "dylank.io."
  containers = [
    {
      name: "node",
      port: 3000,
      cpu: 64,
      memory: 128,
      secrets: [],
      environment_variables: [],
      entry_point: false,
      depends: []
    },
    {
      name: "nginx",
      port: 80,
      cpu: 96,
      memory: 128,
      secrets: [],
      environment_variables: [],
      entry_point: true,
      depends: ["node", "elixir"]
    },    
    {
      name: "elixir",
      port: 8080,
      cpu: 96,
      memory: 256,
      secrets: [],
      environment_variables: [],
      entry_point: false,
      depends: []
    }
  ]

  secrets = []
  environment_variables = []
}
```