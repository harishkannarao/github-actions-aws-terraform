# AWS DB Secret Password Setup

Create a AWS secret with the following command to store DB password

    aws secretsmanager create-secret --name development-rds-db-password --description "RDS DB password." --secret-string "development_db_password"

Verify the created secret using

    aws secretsmanager get-secret-value --secret-id development-rds-db-password --query SecretString --output text