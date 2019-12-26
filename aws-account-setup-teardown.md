## Create AWS s3 bucket and dynamodb
    cd backend

    terraform init -input=false

    terraform apply -auto-approve -input=false

## Teardown AWS s3 bucket and dynamodb

    aws dynamodb delete-table --table-name github-actions-ci-locks

    aws s3 rb s3://github-actions-ci --force

* Delete IAM User through the console
* Delete the IAM User Group through the console