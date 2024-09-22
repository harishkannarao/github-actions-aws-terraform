/*====
RDS
======*/

/* subnet used by rds */
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.environment}-rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = flatten(var.subnet_ids)
  tags = {
    Environment = var.environment
  }
}

/* Security Group for resources that want to access the Database */
resource "aws_security_group" "db_access_sg" {
  vpc_id      = var.vpc_id
  name        = "${var.environment}-db-access-sg"
  description = "Allow access to RDS"

  tags = {
    Name        = "${var.environment}-db-access-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds_sg" {
  name = "${var.environment}-rds-sg"
  description = "${var.environment} Security Group"
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.environment}-rds-sg"
    Environment =  var.environment
  }

  // allows traffic from the SG itself
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      self = true
  }

  //allow traffic for TCP 5432
  ingress {
      from_port = 5432
      to_port   = 5432
      protocol  = "tcp"
      security_groups = [aws_security_group.db_access_sg.id]
  }

  // outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_password" "random_rds_password"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "rds_password" {
  name = "${var.environment}-rdb-db-password"
}

resource "aws_secretsmanager_secret_version" "rds_password_version" {
  secret_id = aws_secretsmanager_secret.rds_password.id
  secret_string = random_password.random_rds_password.result
}

data "aws_secretsmanager_secret" "rds_password_data" {
  name = "${var.environment}-rdb-db-password"
}

data "aws_secretsmanager_secret_version" "rds_password_version" {
  secret_id = data.aws_secretsmanager_secret.rds_password_data
}

resource "aws_db_instance" "rds" {
  identifier             = "${var.environment}-database"
  allocated_storage      = var.allocated_storage
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = var.instance_class
  multi_az               = var.multi_az
  db_name                = var.database_name
  username               = var.database_username
  password               = data.aws_secretsmanager_secret_version.rds_password_version
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
  depends_on             = [aws_secretsmanager_secret_version.rds_password_version]
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
#   snapshot_identifier    = "rds-${var.environment}-snapshot"
  tags = {
    Environment = var.environment
  }
}