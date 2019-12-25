## Create AWS s3 bucket and dynamodb
    cd backend

    terraform init -input=false

    terraform apply -auto-approve -input=false

## Teardown AWS s3 bucket and dynamodb

* Delete the dynamodb table `github-actions-ci-locks` through the console 
* Delete the s3 bucked `github-actions-ci` through the console
* Delete IAM User through the console
* Delete the IAM User Group through the console