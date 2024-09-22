#!/bin/sh

# Make the script to abort if any command fails
set -e

# Print the commands as it is executed. Useful for debugging
set -x

terraform -chdir=environments/$ENV_NAME init -reconfigure -input=false

terraform -chdir=environments/$ENV_NAME plan -input=false -var-file="../../variables/$ENV_NAME.tfvars"

terraform -chdir=environments/$ENV_NAME apply -auto-approve -input=false -var-file="../../variables/$ENV_NAME.tfvars"