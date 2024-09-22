# Connect to RDS instance

## Get RDS DB Host

    aws rds describe-db-instances --db-instance-identifier development-database | jq -r '.DBInstances[].Endpoint.Address'

## Get bastions public ips

    aws ec2 describe-instances --filters "Name=tag:Type,Values=development-bastion" | jq -r '.Reservations[].Instances[].PublicIpAddress' | grep -E '\S' | grep -v 'null'

## Setup necessary file permission for ssh private key

    chmod 400 ignored/ssh-key-development.pem

## Perform SSH with port forwarding to RDS DB

    ssh -o StrictHostKeyChecking=no -L 5432:<aws_rds_host>:5432 -i ignored/ssh-key-development.pem ubuntu@<bastion_public_ip>

Example:

    ssh -o StrictHostKeyChecking=no -L 5432:development-database.cqntfjo5fd4k.eu-west-2.rds.amazonaws.com:5432 -i ignored/ssh-key-development.pem ubuntu@35.178.181.176

## Connect with psql client or any DB client from local machine

    export PGPASSWORD=development_db_password && psql -h localhost -p 5432 -d development_db -U development_db_user