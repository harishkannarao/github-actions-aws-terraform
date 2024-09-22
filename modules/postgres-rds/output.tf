output "rds_address" {
  value = aws_db_instance.rds.address
}

output "db_access_sg_id" {
  value = aws_security_group.db_access_sg.id
}

output "rds_database_identifier" {
  value = aws_db_instance.rds.identifier
}

output "rds_database_password" {
  value = data.aws_secretsmanager_secret_version.rds_password_version.secret_string
}