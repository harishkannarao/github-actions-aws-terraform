# Github Actions + AWS + Terraform

Repository to demonstrate Infrastructur-As-Code using:

* Github Actions Pipelines
* AWS
* Terraform


# AWS Cost Warning

Provisioning cloud resources in AWS will incur cost. Please teardown the cloud resources once the usage is completed.

It is advisable to setup billing alerts or billing threshold in AWS account as a reminder to teardown of cloud resources. This will avoid incurring significant bills.


# Highlights / Acheivements

* Pipelines
    * Application Pipeline
    * Infrastructure Pipeline
    * QA Pipeline
    * Auto triggering QA Pipeline after Deployment
* Zero downtime release (using `Immutable Rolling Deployment`)
* Auto scaling of `ECS Fargate Tasks` based on `cpu` usage
* High Availability AWS resources (`multi availability zones`)
    * Postgres RDS instance
    * NAT Gateway instance with Elastic IP
    * ECS Fargate Tasks
    * Bastion Jumpoff instance
* Log analysis and visualizations with `CloudWatch`
* Provision of multiple environments with reusable `terraform modules`
* `HTTPS` redirection from `HTTP`
* Swagger v2 / OpenApi v3
* `CORS` restriction


# AWS Components Used

* Simple Storage Service (s3)
* Dynamo DB
* AWS Certificate Manager (ACM)
* Virtual Private Cloud (VPC)
* Public Subnets
* Private Subnets
* Internet Gateways (IG)
* NAT Gateways + Elastic IPs
* Application Load Balancer (ALB)
* Security Groups (SG)
* Relational Database Service (RDS)
* Elastic Container Registry (ECR)
* Elastic Container Service (ECS) + Fargate
* Auto Scaling Group (ASG)
* Elastic Cloud Compute (EC2) Bastion
* AWS Key Pair
* Cloudwatch Logs
* Cloudwatch Metrics
* Cloudwatch Alarms


# Documentation


## Accounts Required

* `AWS Account` (Root or IAM)
* `Github Account` (Personal or Enterprise)
* Registered `Domain` with any Domain Registerar


## Tools Required

* `git` cli (any version)
* `aws` cli (minimum version `1.18.40`)
* `terraform` cli (minimum version `0.12.24`)
* `docer` cli (minimum version `19.03.8`)
* `curl` cli (any version)
* `jq` cli (any version)


# Prerequisites


## Setup


### One-off AWS account setup

Setup AWS account with a `IAM user` as described below:

[IAM User Setup](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/IAM_User_Setup.md)

Setup AWS account with `s3 bucket` and `dynamo db` for `terraform` to remotely store the `terraform state` file as described below:

[S3 and Dynamo DB Setup](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/s3_dynamo_db_setup.md)

Setup AWS SSL certificate using `ACM` and validate it as described below:

[AWS SSL Certificate Setup](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_ssl_certificate_setup.md)


### One-off GitHub Actions setup

Add the following values of your AWS account to the GitHub secrets of the repository at

[Github Secrets](https://github.com/harishkannarao/github-actions-aws-terraform/settings/secrets)

| Secret Key | Secret Value |
|---|---|
| AwsAccessKeyId  Access Key of AWS IAM user |
| AwsSecretAccessKey | Secret of the Key of AWS IAM user |

### One-off AWS Environment setup

Create a SSH key pair per environment as described below:

[AWS SSH Key Pair Setup](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_ssh_key_pair_setup.md)

### One-off GitHub Actions Environment setup

Add the following valuesto the GitHub secrets of the repository at

[Github Secrets](https://github.com/harishkannarao/github-actions-aws-terraform/settings/secrets)

| Secret Key | Secret Value |
|---|---|
| DatabaseNameDevelopment | development_db |
| DatabaseUserDevelopment | development_db_user |
| DatabasePasswordDevelopment | development_db_password |
| SshPublicKeyDevelopment | Public key extracted from `.pem` file of AWS Key Pair |


## Teardown


### One-off AWS Environment tear down


### One-off GitHub Actions Environment tear down


### One-off GitHub Actions tear down


### One-off AWS account tear down


# Documentation


### aws cli login & configuration


## Provisioning environment

### Provision environment from local machine

### Provision environment from Github Actions Pipeline

### Deploy sample Java backend application


## Destorying environment

### Destroy environment from local machine

### Destroy environment from Github Actions Pipeline


## Operational Goodies

### Log analysis and visualization with Insights

### Log analysis and visualization with Cloudwatch

### Download logs to local machine

### Remote monitoring ECS Fargate JVM

### Local port forwarding to ECS Fargate Tasks

### Connecting to AWS RDS instance

### SSH into ECS Fargate Tasks

### Create graphs with GraphViz

### Quick roll back of deployment

### Change region and availaibility zones

### Adhoc notes


## Cost Optimisations

The following items can be improved or optimised to reduce AWS cost per environment:

* Resue `ALB` between multiple `ECS` services using multiple `target groups` through:
    * `Host` based routing
    * `Path` based routing
* Reuse `ECS` cluster between multiple `ECS` services


## Further things to explore

* Internal ALB in private Subnets for internal services

* CloudWatch Alarms + Notifications + Alerts from Application Logs

* CloudWatch Dashboards

* Deploy sample node frontend app (React / VueJS)
    * S3 Bucket
    * Cloudfront CDN
    * Custom Domain
    * HTTPS only