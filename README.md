# github-actions-aws-terraform
Repository to practise Infrastructur-As-Code with Github Actions, AWS and Terraform

## Set the secrets for the repo

* AwsAccessKeyId
* AwsSecretAccessKey
* AwsRegion
* database-name-development
* database-user-development
* database-password-development

## Trigger CI to setup, update and destroy

### Set Github personal access token

    export GITHUB_PERSONAL_ACCESS_TOKEN=<<your_personal_token>>

### Terraform apply through CI

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-terraform-apply-aws-from-master-development"}' \
    'https://api.github.com/repos/harishkannarao/github-actions-aws-terraform/dispatches'

### Aws force deploy ecs service through CI

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-aws-force-deploy-ecs-service-development"}' \
    'https://api.github.com/repos/harishkannarao/github-actions-aws-terraform/dispatches'

### Terraform destroy through CI

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-terfform-destroy-aws-from-master-development"}' \
    'https://api.github.com/repos/harishkannarao/github-actions-aws-terraform/dispatches'

## Initialise the backend
    
    export ENV_NAME=development

    export TF_VAR_database_name=development_db

    export TF_VAR_database_username=development_db_user

    export TF_VAR_database_password=development_db_password

    export TF_VAR_image_tag=$ENV_NAME

    terraform init -input=false environments/$ENV_NAME

## Do a dry run and preview the changes to be applied

    terraform plan -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

## Apply the changes

    terraform apply -auto-approve -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

## Destroy the changes

    terraform destroy -auto-approve -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME