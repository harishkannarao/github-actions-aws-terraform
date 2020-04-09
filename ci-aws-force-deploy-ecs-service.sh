#!/bin/sh

# Make the script to abort if any command fails
set -e

# Print the commands as it is executed. Useful for debugging
set -x

aws ecs update-service --cluster $APPLICATION_NAME-$ENVIRONMENT-ecs-cluster --service $APPLICATION_NAME-$ENVIRONMENT --force-new-deployment