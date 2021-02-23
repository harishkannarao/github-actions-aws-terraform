output "rds_address" {
  value = aws_db_instance.rds.address
}

output "db_access_sg_id" {
  value = aws_security_group.db_access_sg.id
}

output "rds_database_identifier" {
  value = aws_db_instance.rds.identifier
}