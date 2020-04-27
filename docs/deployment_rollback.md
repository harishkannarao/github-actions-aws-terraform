# Deployment Rollback

During production deployment, if anything goes wrong, then the following commands will help to quickly roll back to previously deployed version of the app

## Set environment variables

    export DOCKER_AWS_ACCOUNT_ID='{aws_account_id}'
    export DOCKER_AWS_REGION='eu-west-2'
    export ENVIRONMENT='development'
    export APPLICATION_NAME='docker-http-app'
    export REPOSITORY_URI=$DOCKER_AWS_ACCOUNT_ID.dkr.ecr.$DOCKER_AWS_REGION.amazonaws.com/$APPLICATION_NAME/$ENVIRONMENT
    export ROLL_BACK_TAG='{roll_back_version_or_tag_in_ecr}'

## Print docker login with AWS ECR

    aws ecr get-login --registry-ids $DOCKER_AWS_ACCOUNT_ID --region $DOCKER_AWS_REGION --no-include-email

## Login docker client with AWS ECR

    $(aws ecr get-login --registry-ids $DOCKER_AWS_ACCOUNT_ID --region $DOCKER_AWS_REGION --no-include-email)

## Rollback the AWS ECR tag

    docker pull $REPOSITORY_URI:$ROLL_BACK_TAG

    docker tag $REPOSITORY_URI:$ROLL_BACK_TAG $REPOSITORY_URI:$ENVIRONMENT

    docker push $REPOSITORY_URI:$ENVIRONMENT

## Force update AWS ECS to use rolled back ECR tag

    aws ecs update-service --cluster $APPLICATION_NAME-$ENVIRONMENT-ecs-cluster --service $APPLICATION_NAME-$ENVIRONMENT --force-new-deployment