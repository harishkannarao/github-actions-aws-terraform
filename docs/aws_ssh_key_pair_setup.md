# AWS SSH Key Pair for an environment

Generate key pair in aws and store the generated `.pem` file safely

    mkdir -p ignored

    aws ec2 create-key-pair --key-name ssh-key-development --query 'KeyMaterial' --output text > ignored/ssh-key-development.pem

    chmod 400 ignored/ssh-key-development.pem

Generate the public key (`.pub`) from `.pem` file

    ssh-keygen -y -f ignored/ssh-key-development.pem > ignored/ssh-key-development.pub

    chmod 400 ignored/ssh-key-development.pub

Verify the fingerprint in aws

    aws ec2 describe-key-pairs --key-name ssh-key-development