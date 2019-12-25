# github-actions-aws-terraform
Repository to practise Infrastructur-As-Code with Github Actions, AWS and Terraform

## Initialise the backend

    terraform init -input=false

## Do a dry run and preview the changes to be applied

    terraform plan

## Apply the changes

    terraform apply -auto-approve -input=false