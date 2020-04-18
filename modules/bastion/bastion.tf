data "aws_ami" "amazon" {
    most_recent     = true
    owners  = ["self","amazon"]
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "ssh-key-${var.environment}"
  public_key = var.ssh_public_key
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
    ami                         = "${data.aws_ami.amazon.id}"
    instance_type               = "t2.micro"
    security_groups             = flatten([var.security_groups_ids, aws_security_group.bastion-sg.id])
    associate_public_ip_address = true

    tags = {
        Name            = "${var.environment}-bastion-${element(var.availability_zones, count.index)}"
        Type            = "${var.environment}-bastion"
        Environment     = var.environment
    }
}