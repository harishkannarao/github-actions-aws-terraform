# AWS terraform apply from local machine

## Set terraform variables through environment variables

    export ENV_NAME='development'

    export TF_VAR_database_name='development_db'

    export TF_VAR_database_username='development_db_user'

    export TF_VAR_database_password='development_db_password'

## Initialise terraform

    terraform -chdir=environments/$ENV_NAME init -reconfigure -input=false

## Preview the resourced to be created/updated/destroyed

    terraform -chdir=environments/$ENV_NAME plan -input=false -var-file="../../variables/$ENV_NAME.tfvars"

## Apply terraform changes in AWS

    terraform -chdir=environments/$ENV_NAME apply -auto-approve -input=false -var database_password=$TF_VAR_database_password -var-file="../../variables/$ENV_NAME.tfvars"

## Force unlock the terraform state (use only if the process was terminated or killed)

    terraform -chdir=environments/$ENV_NAME force-unlock {ID}