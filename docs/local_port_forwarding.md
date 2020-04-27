# Local port forwarding to remote ECS task

## Get private IPs of running tasks in ECS

    taskArns=$(aws ecs list-tasks --cluster "docker-http-app-development-ecs-cluster" --service-name "docker-http-app-development" | jq -r '.taskArns[]' | grep -E '\S' | tr '\n' ' ')

    aws ecs describe-tasks --cluster "docker-http-app-development-ecs-cluster" --tasks $taskArns | jq -r '.tasks[].containers[].networkInterfaces[].privateIpv4Address'

## Get public IPs of running bastion servers

    aws ec2 describe-instances --filters "Name=tag:Type,Values=development-bastion" | jq -r '.Reservations[].Instances[].PublicIpAddress' | grep -E '\S' | grep -v 'null'

## Set correct file permissions for private key

    chmod 400 ignored/ssh-key-development.pem

## Setup port forwarding using SSH

    ssh -o StrictHostKeyChecking=no -L 8180:<ecs_task_private_ip>:80 -i ignored/ssh-key-development.pem ubuntu@<bastion_public_ip>

Example:

    ssh -o StrictHostKeyChecking=no -L 8180:10.0.20.183:80 -i ignored/ssh-key-development.pem ubuntu@3.8.233.106

## Verify local port forwarding

    curl -s 'http://localhost:8180/health-check'