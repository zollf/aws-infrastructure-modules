module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2"

  identifier             = "rds-mysql-${var.name}"
  engine                 = "mysql"
  engine_version         = "8.0.20"
  family                 = "mysql8.0"
  major_engine_version   = "8.0"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  storage_encrypted      = false
  username               = "rds_user"
  password               = var.rds_password
  port                   = 3306
  multi_az               = false
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.mysql.id]
  maintenance_window     = "Mon:00:00-Mon:03:00"
  backup_window          = "03:00-06:00"
  deletion_protection    = false
}