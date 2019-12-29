# github-actions-aws-terraform
Repository to practise Infrastructur-As-Code with Github Actions, AWS and Terraform

## Initialise the backend

    export ENV_NAME=development

    terraform init -input=false -backend-config="key=terraform-$ENV_NAME.tfstate" 

## Do a dry run and preview the changes to be applied

    terraform plan

## Apply the changes

    terraform apply -var-file="variables/$ENV_NAME.tfvars" -auto-approve -input=false

## Destroy the changes

    terraform destroy -var-file="variables/$ENV_NAME.tfvars" -auto-approve -input=false