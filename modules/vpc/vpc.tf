/*====
The VPC
======*/

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

/*====
Subnets
======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}


/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

/* NAT */
resource "aws_nat_gateway" "nat" {
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = aws_subnet.public_subnet[each.key].id
  depends_on    = [aws_internet_gateway.ig]

  tags = {
    Name        = "${var.environment}-${each.value.availablity_zone}-nat"
    Environment = var.environment
  }
}

/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  cidr_block              = each.value.public_subnet_cidr
  availability_zone       = each.value.availablity_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-${each.value.availablity_zone}-public-subnet"
    Environment = var.environment
  }
}

/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  cidr_block              = each.value.private_subnet_cidr
  availability_zone       = each.value.availablity_zone
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${each.value.availablity_zone}-private-subnet"
    Environment = var.environment
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-${each.value.availablity_zone}-private-route-table"
    Environment = var.environment
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = var.environment
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route" "private_nat_gateway" {
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[each.key].id
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = {for subnet in var.vpc_subnet_cidr: subnet.availablity_zone => subnet}
  subnet_id       = aws_subnet.private_subnet[each.key].id
  route_table_id  = aws_route_table.private[each.key].id
}

/*====
VPC's Default Security Group
======*/
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on  = [aws_vpc.vpc]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Environment = var.environment
  }
}