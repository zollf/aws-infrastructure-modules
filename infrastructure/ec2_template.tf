data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

data "template_file" "ecs_user_data" {
  template = <<EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config
  EOF
}

resource "aws_launch_configuration" "ecs_launch_configuration" {
  name_prefix            = "lc-ecs-${var.name}-"
  image_id               = data.aws_ssm_parameter.ecs_ami.value
  instance_type          = var.ec2_instance_size
  iam_instance_profile   = aws_iam_instance_profile.ecs_instance_profile.name
  security_groups        = [aws_security_group.ecs.id]
  key_name               = module.key_pair.key_pair_key_name
  ebs_optimized          = true
  user_data              = base64encode(data.template_file.ecs_user_data.rendered)

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/xvdcz"
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}