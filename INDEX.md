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

# AWS Components

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

[S3 and Dynamo DB](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/s3_dynamo_db.md)

### One-off GitHub Actions setup

### One-off AWS Environment setup

### One-off GitHub Actions Environment setup

### One-off CNAME entry with domain provider

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

## Operational Stuffs

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