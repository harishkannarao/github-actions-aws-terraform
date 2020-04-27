#!/bin/sh

# Make the script to abort if any command fails
set -e

# Print the commands as it is executed. Useful for debugging
set -x

terraform init -input=false environments/$ENV_NAME

terraform plan -destroy -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME

terraform destroy -auto-approve -input=false -var-file="variables/$ENV_NAME.tfvars" environments/$ENV_NAME