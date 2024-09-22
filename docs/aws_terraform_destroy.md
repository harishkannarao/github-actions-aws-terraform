# Destroy AWS resources using terraform from local machine

## Set terraform variables through environment variables

    export ENV_NAME='development'

## Initialise terraform

    terraform -chdir=environments/$ENV_NAME init  -reconfigure -input=false

## Preview the resources to be destroyed

    terraform -chdir=environments/$ENV_NAME plan -destroy -input=false -var-file="../../variables/$ENV_NAME.tfvars"

## Destroy the resources in AWS

    terraform -chdir=environments/$ENV_NAME destroy -auto-approve -input=false -var-file="../../variables/$ENV_NAME.tfvars"