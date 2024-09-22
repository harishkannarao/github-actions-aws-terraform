# AWS DB Secret Password Teardown

Delete db secret password by name

    aws secretsmanager delete-secret --secret-id development-rds-db-password --force-delete-without-recovery