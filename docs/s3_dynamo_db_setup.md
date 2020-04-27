# S3 and Dynamo DB for terraform

## Create AWS s3 bucket for storing terraform state file

    aws s3api create-bucket --bucket github-actions-ci --acl private --create-bucket-configuration LocationConstraint=eu-west-2

## Optional - Enable versioning for AWS s3 bucket

    aws s3api put-bucket-versioning --bucket github-actions-ci --versioning-configuration Status=Enabled

## Create AWS dynamodb table for locking

    aws dynamodb create-table --table-name github-actions-ci-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST