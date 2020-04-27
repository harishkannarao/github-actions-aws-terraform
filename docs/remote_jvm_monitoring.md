# Remote JVM monitoring using VisualVM

## Get private IPs of running tasks in ECS

    taskArns=$(aws ecs list-tasks --cluster "docker-http-app-development-ecs-cluster" --service-name "docker-http-app-development" | jq -r '.taskArns[]' | grep -E '\S' | tr '\n' ' ')

    aws ecs describe-tasks --cluster "docker-http-app-development-ecs-cluster" --tasks $taskArns | jq -r '.tasks[].containers[].networkInterfaces[].privateIpv4Address'

## Get public IPs of running bastion servers

    aws ec2 describe-instances --filters "Name=tag:Type,Values=development-bastion" | jq -r '.Reservations[].Instances[].PublicIpAddress' | grep -E '\S' | grep -v 'null'

## Set correct file permissions for private key

    chmod 400 ignored/ssh-key-development.pem

## Setup port forwarding using SSH

    ssh -o StrictHostKeyChecking=no -L 10006:<ecs_task_private_ip>:10006 -i ignored/ssh-key-development.pem ubuntu@<bastion_public_ip>

Example:

    ssh -o StrictHostKeyChecking=no -L 10006:10.0.20.183:10006 -i ignored/ssh-key-development.pem ubuntu@3.8.233.106

## Connect VisualVM in local machine

Local Visual VM uri

    service:jmx:rmi:///jndi/rmi://localhost:10006/jmxrmi

Setup Instructions as described in this blog

[Harish's blog on VisualVM](https://blogs.harishkannarao.com/2019/03/remote-jvm-monitoring-using-visualvm.html)