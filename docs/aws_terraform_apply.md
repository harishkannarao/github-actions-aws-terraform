# AWS terraform apply from local machine

## Set terraform variables through environment variables

    export ENV_NAME='development'

    export TF_VAR_database_name='development_db'

    export TF_VAR_database_username='development_db_user'

    export TF_VAR_database_password='development_db_password'

## Initialise terraform

    terraform init -reconfigure -input=false environments/$ENV_NAME

## Preview the resourced to be created/updated/destroyed

    terraform plan -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

## Apply terraform changes in AWS

    terraform apply -auto-approve -input=false -var database_password=$TF_VAR_database_password -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME