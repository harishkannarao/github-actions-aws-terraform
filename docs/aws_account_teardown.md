# AWS Account Teardown

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

## Delete any leftover SSH key pairs

#### Delete all keys

    aws ec2 describe-key-pairs | jq -r '.KeyPairs[].KeyName' | xargs -I {} aws ec2 delete-key-pair --key-name {}