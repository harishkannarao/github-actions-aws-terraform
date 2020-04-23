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

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group-${var.environment}"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
    count                       = length(var.availability_zones)
    availability_zone           = element(var.availability_zones, count.index)
    subnet_id                   = element(flatten(var.public_subnet_ids), count.index)
    ami                         = data.aws_ami.ubuntu.id
    user_data                   = file("${path.module}/bastion_setup.sh")
    instance_type               = "t2.nano"
    security_groups             = flatten([var.security_groups_ids, aws_security_group.bastion-sg.id])
    key_name                    = var.ssh_key_pair_name
    associate_public_ip_address = true

    tags = {
        Name            = "${var.environment}-bastion-${element(var.availability_zones, count.index)}"
        Type            = "${var.environment}-bastion"
        Environment     = var.environment
    }
}