data "aws_ami" "amzn2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

resource "aws_security_group" "vpc_ssh_access" {
  name        = "sg-vpc-ssh-${var.name}"
  description = "SSH access into the VPC"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vpc_ssh_access" {
  ami                    = data.aws_ami.amzn2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vpc_ssh_access.id]

  subnet_id = module.vpc.public_subnets[0]

  key_name = module.key_pair.key_pair_key_name

  tags = {
    Name = "${var.name}"
    Terraform = "True"
  }
}