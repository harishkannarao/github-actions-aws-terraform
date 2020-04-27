# AWS cli login

## Non-interactive login

    export AWS_ACCESS_KEY_ID='<aws_account_key_id>'
    
    export AWS_SECRET_ACCESS_KEY='<aws_account_secret_key>'
    
    export AWS_DEFAULT_REGION='eu-west-2'
    
    export AWS_DEFAULT_OUTPUT='json'

## Interactive login

    aws configure

Enter the following values:

* AWS Access Key ID: {Enter the generated access key}
* AWS Secret Access Key: {Enter the generated secret key}
* Default region name: eu-west-2
* Default output format: json

## Verify login

    aws configure list

    aws sts get-caller-identity 