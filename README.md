# AWS Infrastructure Module
My aws infrastructure module.

## Naming Conventions
| Resource              | Naming Convention                   |
| --------------------- | ----------------------------------- |
| VPC                   | `vpc-<region>-<name>`               |
| ECS                   | `ecs-<region>-<name>`               |
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