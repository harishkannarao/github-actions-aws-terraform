# AWS terraform apply from local machine

## Change directory

    cd /github-actions-aws-terraform/

## Set terraform variables through environment variables

    export ENV_NAME='development'

## Initialise terraform

    terraform -chdir=environments/$ENV_NAME init -reconfigure -input=false

## Initialise terraform and update the lock file with configuration

    terraform -chdir=environments/$ENV_NAME init -upgrade -reconfigure -input=false

## Validate configuration

    terraform -chdir=environments/$ENV_NAME validate

## Preview the resourced to be created/updated/destroyed

    terraform -chdir=environments/$ENV_NAME plan -input=false -var-file="../../variables/$ENV_NAME.tfvars"

## Apply changes in AWS

    terraform -chdir=environments/$ENV_NAME apply -auto-approve -input=false -var-file="../../variables/$ENV_NAME.tfvars"

## Force unlock the terraform state (use only if the process was terminated or killed)

    terraform -chdir=environments/$ENV_NAME force-unlock {ID}