# Destroy AWS resources using terraform from local machine

## Set terraform variables through environment variables

    export ENV_NAME='development'

    export TF_VAR_database_name='development_db'

    export TF_VAR_database_username='development_db_user'

    export TF_VAR_database_password='development_db_password'

## Initialise terraform

    terraform init -input=false environments/$ENV_NAME

## Preview the resources to be destroyed

    terraform plan -destroy -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

## Destroy the resources in AWS

    terraform destroy -auto-approve -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME