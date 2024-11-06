# AWS SSH Key Pair Teardown

Delete a key pair by name

    aws ec2 delete-key-pair --key-name ssh-key-development

Delete the public key in secrets manager

    aws secretsmanager delete-secret --secret-id ssh-key-development --force-delete-without-recovery