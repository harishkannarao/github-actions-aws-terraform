# github-actions-aws-terraform
Repository to practise Infrastructur-As-Code with Github Actions, AWS and Terraform

## Required cli tools

* `aws` cli
* `terraform` cli
* `curl` cli
* `jq` cli
* `git` cli

## Set the secrets for the repo

* AwsAccessKeyId
* AwsSecretAccessKey
* DatabaseNameDevelopment
* DatabaseUserDevelopment
* DatabasePasswordDevelopment
* SshPublicKeyDevelopment

## Trigger CI to setup, update and destroy

### Set Github personal access token

    export GITHUB_PERSONAL_ACCESS_TOKEN=<<your_personal_token>>

### Terraform apply through CI

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-terraform-apply-aws-from-master-development"}' \
    'https://api.github.com/repos/harishkannarao/github-actions-aws-terraform/dispatches'

### Terraform destroy through CI

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-terfform-destroy-aws-from-master-development"}' \
    'https://api.github.com/repos/harishkannarao/github-actions-aws-terraform/dispatches'

## Get the terraform state from aws s3 bucket

    aws s3api get-object --bucket "github-actions-ci" --key "terraform-development.tfstate" ignored/terraform-development.tfstate

ALB Dns Name:

    aws s3api get-object --bucket "github-actions-ci" --key "terraform-development.tfstate" /dev/stdout | jq -r '.outputs["alb-dns-name"].value' | grep -E '\S' | grep -v 'null'

## Initialise the backend
    
    export AWS_ACCESS_KEY_ID='<aws_account_key_id>'
    
    export AWS_SECRET_ACCESS_KEY='<aws_account_secret_key>'
    
    export AWS_DEFAULT_REGION='eu-west-2'
    
    export AWS_DEFAULT_OUTPUT='json'


    export ENV_NAME='development'

    export TF_VAR_database_name='development_db'

    export TF_VAR_database_username='development_db_user'

    export TF_VAR_database_password='development_db_password'

    export TF_VAR_ssh_public_key='<ssh_public_key>'

    terraform init -input=false environments/$ENV_NAME

## Validate the template

    terraform validate -json environments/$ENV_NAME

## Do a dry run and preview the changes to be applied

    terraform plan -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

## Apply the changes

    terraform apply -auto-approve -input=false -var database_password=$TF_VAR_database_password -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

## Destroy the changes

    terraform destroy -auto-approve -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME