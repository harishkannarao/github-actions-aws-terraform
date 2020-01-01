# github-actions-aws-terraform
Repository to practise Infrastructur-As-Code with Github Actions, AWS and Terraform

## Initialise the backend
    
    export ENV_NAME=development

    terraform init -input=false environments/$ENV_NAME

## Do a dry run and preview the changes to be applied

    terraform plan -input=false environments/$ENV_NAME

## Apply the changes

    terraform apply -auto-approve -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

## Destroy the changes

    terraform destroy -auto-approve -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME