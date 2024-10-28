# SSH into Application instance 

## View all ecs clusters

    aws ecs list-clusters --output text

## View all ecs services in a cluster

    aws ecs list-services --cluster "docker-http-app-development-ecs-cluster" --output text

## Get private IPs of running tasks in an ECS Cluster by Service Name

    taskArns=$(aws ecs list-tasks --cluster "docker-http-app-development-ecs-cluster" --service-name "docker-http-app-development" --output json | jq -r '.taskArns[]' | grep -E '\S' | tr '\n' ' ')

    aws ecs describe-tasks --cluster "docker-http-app-development-ecs-cluster" --tasks $taskArns | jq -r '.tasks[].containers[].networkInterfaces[].privateIpv4Address'

## Get public IPs of running bastion servers

    aws ec2 describe-instances --filters "Name=tag:Type,Values=development-bastion" | jq -r '.Reservations[].Instances[].PublicIpAddress' | grep -E '\S' | grep -v 'null'

## Set correct file permissions for private key

    chmod 400 ignored/ssh-key-development.pem

## Add ssh key

    ssh-add ignored/ssh-key-development.pem

    ssh-add -L

## SSH into bastion box

    ssh -o StrictHostKeyChecking=no -A -i ignored/ssh-key-development.pem ubuntu@<bastion_public_ip>

Example:

    ssh -o StrictHostKeyChecking=no -A -i ignored/ssh-key-development.pem ubuntu@35.178.23.17

## Verify the added private key in bastion for this session

    ssh-add -L

## SSH into ECS task container

    ssh -o StrictHostKeyChecking=no root@<ecs_task_private_ip>

Example:

    ssh -o StrictHostKeyChecking=no root@10.0.30.51

## Sample commands to run in ECS task container

    top

    curl -s 'http://localhost/health-check' | jq

    curl -s 'https://docker-http-app-development.harishkannarao.com/health-check' | jq

## Exit from task container

    exit

## Clear SSH keys in bastion before exit

    ssh-add -D 

    exit

## Clear SSH keys from local machine afer ssh session

    ssh-add -D