terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.54.1"
    }
  }
}

/* Security Group for Bastion */
resource "aws_security_group" "bastion_sg" {
  vpc_id      = var.vpc_id
  name        = "bastion-${var.environment}-sg"
  description = "Bastion sg"

  tags = {
    Name        = "bastion-${var.environment}-sg"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_egress_rule" "bastion_egress_rule" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  from_port         = 0
  to_port           = 0
}

resource "aws_vpc_security_group_ingress_rule" "bastion_ingress_rule" {
  for_each          = var.bastion_ingress_rules
  security_group_id = aws_security_group.bastion_sg.id
  description       = each.key
  cidr_ipv4         = each.value.cidr_ipv4
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "bastion_launch_configuration" {
  name                        = "${var.environment}-bastion-launch-configuration"
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  user_data = file("${path.module}/bastion_setup.sh")
  security_groups = flatten([var.security_groups_ids, aws_security_group.bastion_sg.id])
  key_name                    = var.ssh_key_pair_name
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "${var.environment}-bastion-asg"
  launch_configuration = aws_launch_configuration.bastion_launch_configuration.name
  health_check_type    = "EC2"
  vpc_zone_identifier = flatten([var.public_subnet_ids])
  min_size             = 1
  max_size             = 1

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Type"
    value               = "${var.environment}-bastion"
    propagate_at_launch = true
  }
}