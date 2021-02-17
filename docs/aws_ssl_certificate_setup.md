# AWS SSL Certificate using ACM

## Request a certificate from ACM for root domain and all subdomains using wildcard

    aws acm request-certificate --domain-name harishkannarao.com --subject-alternative-names *.harishkannarao.com --validation-method DNS

    aws acm list-certificates

    aws acm describe-certificate --certificate-arn <certificate_arn>

## Request a certificate from ACM for root domain in us-east-1 region for usage in cloudfront

    AWS_DEFAULT_REGION=us-east-1 aws acm request-certificate --domain-name harishkannarao.com --subject-alternative-names *.harishkannarao.com --validation-method DNS

    AWS_DEFAULT_REGION=us-east-1 aws acm list-certificates

    AWS_DEFAULT_REGION=us-east-1 aws acm describe-certificate --certificate-arn <certificate_arn>

## Create cname entries with your domain registrar and get the domain/certificate status as validated

### Get CNAME Name:

    aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ResourceRecord.Name' | sed  s/.$//

### Get CNAME Value to be entered in Pointing To:

    aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ResourceRecord.Value' | sed  s/.$//

### Get CNAME Name in us-east-1 region:

    AWS_DEFAULT_REGION=us-east-1 aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ResourceRecord.Name' | sed  s/.$//

### Get CNAME Value to be entered in Pointing To:

    AWS_DEFAULT_REGION=us-east-1 aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ResourceRecord.Value' | sed  s/.$//

## Check ACM validation status:

After creating the `cname` entry with domain registrar, wait for the status to be `SUCCESS` 

    aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ValidationStatus'

    AWS_DEFAULT_REGION=us-east-1 aws acm describe-certificate --certificate-arn <certificate_arn> | jq -r '.Certificate.DomainValidationOptions[0].ValidationStatus'