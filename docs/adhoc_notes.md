# Adhoc Notes

### Run aws and terraform in docker

    cd $HOME/professional/learning

    git clone git@github.com:harishkannarao/aws_cli_docker.git

    cd aws_cli_docker

    docker build --pull -t harishkannarao/awscli:latest -f Dockerfile .

    export AWS_ACCESS_KEY_ID_TERRAFORM='<aws_account_key_id>'
    export AWS_SECRET_ACCESS_KEY_TERRAFORM='<aws_account_secret_key>'

    docker run --rm -it \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_TERRAFORM" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_TERRAFORM" \
    -e "AWS_DEFAULT_REGION=eu-west-2" \
    -e "AWS_DEFAULT_OUTPUT=json" \
    -v $HOME/professional/learning/github-actions-aws-terraform:/github-actions-aws-terraform \
    harishkannarao/awscli:latest /bin/bash

    cd /github-actions-aws-terraform/

    aws configure list

    aws sts get-caller-identity 

### Using EC2 Instance connect

    ssh-keygen -t rsa -f ignored/mynew_key

    chmod 400 ignored/mynew_key

    aws ec2-instance-connect send-ssh-public-key --region eu-west-2 --instance-id i-08fea708eb9c53fa0 --availability-zone eu-west-2b --instance-os-user ubuntu --ssh-public-key file://ignored/mynew_key.pub

    ssh -i mynew_key ubuntu@3.8.181.133

### SNS topic subscription

#### Get topic arn

    snsTopicArn=$(aws s3api get-object --bucket "github-actions-ci" --key "terraform-development.tfstate" /dev/stdout | jq -r '.outputs["alarm_topic_arn"].value' | grep -E '\S' | grep -v 'null')

    echo $snsTopicArn

#### List existing subscriptions for this topic

    aws sns list-subscriptions-by-topic --topic-arn "$snsTopicArn" --no-paginate

#### Subscribe an email

    aws sns subscribe --topic-arn "$snsTopicArn" --protocol email --notification-endpoint your_email@example.com

Note: **Confirm the subscription by validating the link sent to the email**

#### Unsubscribe an email

Get the subscription arn by email

    subscriptionArn=$(aws sns list-subscriptions-by-topic --topic-arn "$snsTopicArn" --no-paginate --output text | grep 'your_email@example.com' | cut -f 5)

    echo $subscriptionArn

    aws sns unsubscribe --subscription-arn $subscriptionArn

