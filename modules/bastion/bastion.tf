data "aws_ami" "ubuntu" {
    most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "bastion_launch_configuration" {
  name = "${var.environment}-bastion-launch-configuration"
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data = file("${path.module}/bastion_setup.sh")
  security_groups = var.security_groups_ids
  key_name = var.ssh_key_pair_name
  associate_public_ip_address = true
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion_asg" {
  name                 = "${var.environment}-bastion-asg"
  launch_configuration = aws_launch_configuration.bastion_launch_configuration.name
  health_check_type    = "EC2"
  vpc_zone_identifier  = flatten([var.public_subnet_ids])
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