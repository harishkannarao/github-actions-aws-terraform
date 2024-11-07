# Adhoc Notes

### Run aws and terraform in docker

    cd $HOME//Users/harishkannarao/Professional/Learningss

    git clone git@github.com:harishkannarao/aws_cli_docker.git

    cd aws_cli_docker

    docker build --pull -t harishkannarao/awscli:latest -f Dockerfile .

    export AWS_ACCESS_KEY_ID_TERRAFORM='<aws_account_key_id>'
    export AWS_SECRET_ACCESS_KEY_TERRAFORM='<aws_account_secret_key>'

    docker run --rm --name aws-cli-latest -it \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_TERRAFORM" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_TERRAFORM" \
    -e "AWS_DEFAULT_REGION=eu-west-2" \
    -e "AWS_DEFAULT_OUTPUT=json" \
    -e "ENV_NAME=development" \
    -v $HOME/Professional/Learnings/github-actions-aws-terraform:/github-actions-aws-terraform \
    -w /github-actions-aws-terraform \
    harishkannarao/awscli:latest /bin/bash

    aws configure list

    aws sts get-caller-identity 

### Attach to existing client in a new terminal

     docker exec -it aws-cli-latest /bin/bash

### Using EC2 Instance connect

    ssh-keygen -t rsa -f ignored/mynew_key

    chmod 400 ignored/mynew_key

    aws ec2-instance-connect send-ssh-public-key --region eu-west-2 --instance-id i-08fea708eb9c53fa0 --availability-zone eu-west-2b --instance-os-user ubuntu --ssh-public-key file://ignored/mynew_key.pub

    ssh -i mynew_key ubuntu@3.8.181.133

