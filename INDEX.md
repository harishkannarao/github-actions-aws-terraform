# github-actions-aws-terraform

Repository to demonstrate Infrastructur-As-Code using:

* Github Actions Pipelines
* AWS
* Terraform

## AWS Cost Warning

Provisioning cloud resources in AWS will incur cost. Please teardown the cloud resources once the usage is completed.

It is advisable to setup billing alerts or billing threshold in AWS account as a reminder to teardown of cloud resources. This will avoid incurring significant bills.

### Accounts Required

* `AWS Account` (Root or IAM)
* `Github Account` (Personal or Enterprise)

### Tools Required

* `git` cli (any version)
* `aws` cli (minimum version `1.18.40`)
* `terraform` cli (minimum version `0.12.24`)
* `docer` cli (minimum version `19.03.8`)
* `curl` cli (any version)
* `jq` cli (any version)


# Prerequisites

## Setup

### One-off AWS account setup

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

## Further things to explore

### Internal ALB in private Subnets for internal services

### CloudWatch Alarms + Notifications + Alerts from Application Logs

### CloudWatch Dashboards