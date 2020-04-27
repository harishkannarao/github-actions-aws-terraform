# Copy files to bastion using scp

## Get public IPs of running bastion servers

    aws ec2 describe-instances --filters "Name=tag:Type,Values=development-bastion" | jq -r '.Reservations[].Instances[].PublicIpAddress' | grep -E '\S' | grep -v 'null'

## Set correct file permissions for private key

    chmod 400 ignored/ssh-key-development.pem

## Copy local machine file to bastion

    scp -o StrictHostKeyChecking=no -i ignored/ssh-key-development.pem ignored/local_file.txt ubuntu@<bastion_public_ip>:~

    ssh -o StrictHostKeyChecking=no -i ignored/ssh-key-development.pem ubuntu@<bastion_public_ip>

    cat local_file.txt

## Copy file from bastion to local machine

    scp -o StrictHostKeyChecking=no -i ignored/ssh-key-development.pem ubuntu@<bastion_public_ip>:~/remote_file.txt ignored

    cat ignored/remote_file.txt 