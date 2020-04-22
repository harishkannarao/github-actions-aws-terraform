# Setup

## Create AWS IAM Group using root user or adminstrator user

    aws iam create-group --group-name terraform-group

    aws iam create-group --group-name terraform-group-2

## Attach needed policies to IAM Group using root user or adminstrator user

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRDSFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonECS_FullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AWSElasticBeanstalkFullAccess --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/EC2InstanceConnect --group-name terraform-group-2

## Create AWS IAM User using root user or adminstrator user

    aws iam create-user --user-name terraform-user

## Create access key for IAM user and note down the access key

    aws iam create-access-key --user-name terraform-user

## Attach the user to terraform group

    aws iam add-user-to-group --user-name terraform-user --group-name terraform-group

    aws iam add-user-to-group --user-name terraform-user --group-name terraform-group-2

## Create AWS s3 bucket and dynamodb

    aws s3api create-bucket --bucket github-actions-ci --acl private --create-bucket-configuration LocationConstraint=eu-west-2

## Optional - Enable versioning for AWS s3 bucket
    aws s3api put-bucket-versioning --bucket github-actions-ci --versioning-configuration Status=Enabled

## Create AWS dynamodb table for locking

    aws dynamodb create-table --table-name github-actions-ci-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST

## Create AWS Service Roles

    aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com

    aws iam create-service-linked-role --aws-service-name ecs.application-autoscaling.amazonaws.com

    aws iam create-service-linked-role --aws-service-name elasticbeanstalk.amazonaws.com

## Create SSL cerftificates using AWS ACM

    aws acm request-certificate --domain-name harishkannarao.com --subject-alternative-names *.harishkannarao.com --validation-method DNS

    aws acm list-certificates

    aws acm describe-certificate --certificate-arn <certificate_arn>

Create cname entries with your domain registrar and get the domain/certificate status as validated

CNAME Name:

    aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ResourceRecord.Name' | sed  s/.$//

CNAME Value:

    aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ResourceRecord.Value' | sed  s/.$//

Check ACM validation status:

    aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ValidationStatus'


## Create SSH key pair per environment

    aws ec2 create-key-pair --key-name ssh-key-development --query 'KeyMaterial' --output text > ignored/ssh-key-development.pem

    chmod 400 ignored/ssh-key-development.pem

    ssh-keygen -y -f ignored/ssh-key-development.pem > ignored/ssh-key-development.pub

    chmod 400 ignored/ssh-key-development.pub

    aws ec2 describe-key-pairs --key-name ssh-key-development


# Teardown

## Delete dynamodb table

    aws dynamodb delete-table --table-name github-actions-ci-locks

## Teardown AWS s3 bucket

    aws s3 rb s3://github-actions-ci --force

## Teardown AWS Terraform user

    aws iam remove-user-from-group --user-name terraform-user --group-name terraform-group

    aws iam list-access-keys --user-name terraform-user | jq -r '.AccessKeyMetadata[].AccessKeyId' | xargs -I {} aws iam delete-access-key --user-name terraform-user --access-key-id {}

    aws iam delete-user --user-name terraform-user

## Teardown AWS Terraform group

    aws iam list-attached-group-policies --group-name terraform-group | jq -r '.AttachedPolicies[].PolicyArn' | xargs -I {} aws iam detach-group-policy --group-name terraform-group --policy-arn {}

    aws iam delete-group --group-name terraform-group

## Teardown AWS Service roles

    aws iam delete-service-linked-role --role-name AWSServiceRoleForECS

    aws iam delete-service-linked-role --role-name AWSServiceRoleForApplicationAutoScaling_ECSService

    aws iam delete-service-linked-role --role-name AWSServiceRoleForElasticBeanstalk

## Delete SSH key pairs for all environments

#### Delete using key name

    aws ec2 delete-key-pair --key-name ssh-key-development

#### Delete all keys

    aws ec2 describe-key-pairs | jq -r '.KeyPairs[].KeyName' | xargs -I {} aws ec2 delete-key-pair --key-name {}