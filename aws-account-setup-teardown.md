## Create AWS IAM Group using root user or adminstrator user

    aws iam create-group --group-name terraform-group

## Attach needed policies to IAM Group using root user or adminstrator user

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRDSFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AWSElasticBeanstalkFullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name terraform-group

## Create AWS IAM User using root user or adminstrator user

    aws iam create-user --user-name terraform-user

## Create access key for IAM user and note down the access key

    aws iam create-access-key --user-name terraform-user

## Attach the user to terraform group

    aws iam add-user-to-group --user-name terraform-user --group-name terraform-group

## Create AWS s3 bucket and dynamodb

    aws s3api create-bucket --bucket github-actions-ci --acl private --create-bucket-configuration LocationConstraint=eu-west-2

    # optionally enable versioning for s3 bucket
    # aws s3api put-bucket-versioning --bucket github-actions-ci --versioning-configuration Status=Enabled

    aws dynamodb create-table --table-name github-actions-ci-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST

## Teardown AWS s3 bucket and dynamodb

    aws dynamodb delete-table --table-name github-actions-ci-locks

    aws s3 rb s3://github-actions-ci --force

## Teardown AWS Terraform user

    aws iam remove-user-from-group --user-name terraform-user --group-name terraform-group

Get the access keys and delete all access keys

    aws iam list-access-keys --user-name terraform-user | jq -r '.AccessKeyMetadata[].AccessKeyId' | xargs -I {} aws iam delete-access-key --user-name terraform-user --access-key-id {}

    aws iam delete-user --user-name terraform-user

## Teardown AWS Terraform group

    aws iam list-attached-group-policies --group-name terraform-group | jq -r '.AttachedPolicies[].PolicyArn' | xargs -I {} aws iam detach-group-policy --group-name terraform-group --policy-arn {}

    aws iam delete-group --group-name terraform-group