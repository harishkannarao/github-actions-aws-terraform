# Github Actions + AWS + Terraform

Repository to demonstrate Infrastructur-As-Code using:

* Github Actions Pipelines
* AWS
* Terraform

# Blog about this repository

Please read my blog to know about the background and purpose of this sample repository

[Empowering Backend Engineering Team](https://blogs.harishkannarao.com/2020/05/things-that-empower-backend-engineering.html)

# AWS Cost Warning

Provisioning cloud resources in AWS will incur cost. Please teardown the cloud resources once the usage is completed.

It is advisable to setup billing alerts or billing threshold in AWS account as a reminder to teardown of cloud resources. This will avoid incurring significant bills.


# Highlights / Achievements

* Isolated `Containerised` Pipelines
    * Application `CI+CD` Pipeline
        * [Screen Shot 1](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/application_pipeline.png)
        * [Screen Shot 2](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/application_pipeline_steps.png)
    * Infrastructure `CD` Pipeline
        * [Screen Shot 1](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/infrastructure_pipeline.png)
        * [Screen Shot 2](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/infrastructure_pipeline_steps.png)
    * QA `CI` Pipeline
        * [Screen Shot 1](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/qa_acceptance_pipeline.png)
        * [Screen Shot 2](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/qa_acceptance_pipeline_steps.png)
    * Auto triggering `QA CI Pipeline` after every `successful` Deployment
* Zero downtime release (using `Immutable Rolling Deployment`)
    * [Screen Shot](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/ecs_rolling_deployment.png)
* Auto scaling of `ECS Fargate Tasks` based on `cpu` usage
    * [Screen Shot 1](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/ecs_auto_scaling.png)
    * [Screen Shot 2](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/ecs_auto_scaling_tasks.png)
* Remote JVM Monitoring
    * [Screen Shot](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/visual_vm_jvm_monitoring.png)
* High Availability AWS resources (`multi availability zones`)
    * Postgres RDS instance
        * [Screen Shot](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/rds_db_configuration.png)
    * NAT Gateway instance with Elastic IP
    * ECS Fargate Tasks
    * Bastion Jumpoff instance
* Cloudwatch Dashboard
    * Infrastructure Dashboard
    * Application Dashboard
    * [Screen Shot 1](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/cloudwatch_dashboard_1.png)
    * [Screen Shot 2](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/cloudwatch_dashboard_2.png)
    * [Screen Shot 3](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/cloudwatch_dashboard_3.png)
* Cloudwatch Alerts to Email
    * Critical Infrastructure Metrics
    * Critical Application Metrics
    * [Screen Shot](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/cloudwatch_alarms.png)
* Log Visualizations and Log analysis with `CloudWatch`
    * [Screen Shot](https://raw.githubusercontent.com/harishkannarao/github-actions-aws-terraform/master/screenshots/cloudwatch_log_insights.png)
* Provision of multiple environments with reusable `terraform modules`
* `HTTPS` redirection from `HTTP` through `ALB` listener rule
* Swagger v2 + OpenApi v3
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
* Cloudwatch Dashboard
* Cloudwatch Logs
* Cloudwatch Metrics
* Cloudwatch Alarms
* AWS Simple Notification Service


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
* `psql` cli (any version) or any Postgres compatible DB client

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
| AwsAccessKeyId | Access Key of AWS IAM user |
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


## Teardown


### One-off AWS Environment tear down

Delete SSH Key Pair generated for the environment as described below:

[AWS SSH Key Pair Teardown](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_ssh_key_pair_teardown.md)


### One-off GitHub Actions Environment tear down

Delete the following secret keys from

[Github Secrets](https://github.com/harishkannarao/github-actions-aws-terraform/settings/secrets)

**Keys:**

* DatabaseNameDevelopment
* DatabaseUserDevelopment
* DatabasePasswordDevelopment

### One-off GitHub Actions tear down

Delete the following secret keys from

[Github Secrets](https://github.com/harishkannarao/github-actions-aws-terraform/settings/secrets)

**Keys:**

* AwsAccessKeyId
* AwsSecretAccessKey


### One-off AWS account tear down

Clean up AWS account as described below:

[AWS Account Teardown](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_account_teardown.md)


# Documentation


### aws cli login & configuration

Login to `aws` cli as described below:

[AWS cli login](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_cli_login.md)

Verify login:

    aws configure list

    aws sts get-caller-identity


## Provisioning environment

### Provision environment from Github Actions Pipeline

Generate github personal access token with `repo` scope at

[Generate Github Personal Token](https://github.com/settings/tokens)


    export GITHUB_PERSONAL_ACCESS_TOKEN=<<your_personal_token>>

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-terraform-apply-aws-from-master-development"}' \
    'https://api.github.com/repos/harishkannarao/github-actions-aws-terraform/dispatches'

View the running pipeline at:

[Infrastructure Pipeline](https://github.com/harishkannarao/github-actions-aws-terraform/actions)


### Provision environment from local machine

Provision infrastructure using terraform from local machine as described below:

[AWS terraform apply](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_terraform_apply.md)


### Setup cname with domain registrar

Get `ALB public dns domain`

    aws s3api get-object --bucket "github-actions-ci" --key "terraform-development.tfstate" /dev/stdout | jq -r '.outputs["alb-dns-name"].value' | grep -E '\S' | grep -v 'null'

Get `Cloudfront public dns domain`

    aws s3api get-object --bucket "github-actions-ci" --key "terraform-development.tfstate" /dev/stdout | jq -r '.outputs["www_distribution_domain_name"].value' | grep -E '\S' | grep -v 'null'

Setup `cname` with domain registrar as:

* cname: `docker-http-app-development` pointing to: `ALB public dns domain`
* cname: `http-web-development` pointing to: `Cloudfront public dns domain`

### Deploy sample http API using Application Pipeline

Open Source Sample Java Spring Boot (API) Application at Github

* [MySpringBoot](https://github.com/harishkannarao/MySpringBoot)
* [CI Configuration](https://github.com/harishkannarao/MySpringBoot/blob/master/.github/workflows/CI-deploy-master-to-aws-development.yml)
* [Building Docker Image](https://github.com/harishkannarao/MySpringBoot/blob/master/ci-build-docker.sh)
* [Push Docker Image and Update ECS Service](https://github.com/harishkannarao/MySpringBoot/blob/master/ci-push-docker.sh)

#### Generate github personal access token with `repo` scope at

[Generate Github Personal Token](https://github.com/settings/tokens)


    export GITHUB_PERSONAL_ACCESS_TOKEN=<<your_personal_token>>

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-deploy-master-to-aws-development"}' \
    'https://api.github.com/repos/harishkannarao/MySpringBoot/dispatches'

#### View the running pipeline at:

[Application Pipeline](https://github.com/harishkannarao/MySpringBoot/actions)

After successful run, the application will be accessible at:

    https://docker-http-app-development.harishkannarao.com/health-check

    https://docker-http-app-development.harishkannarao.com/swagger-ui.html

    https://docker-http-app-development.harishkannarao.com/swagger-ui/index.html?configUrl=/api-docs/swagger-config


### Deploy sample frontent web application using Application Pipeline

Open Source Sample ReactJs + NextJs + NodeJs web application at Github

* [react-nextjs-rest-api](https://github.com/harishkannarao/react-nextjs-rest-api)
* [CI Configuration](https://github.com/harishkannarao/react-nextjs-rest-api/blob/main/.github/workflows/CI-deploy-main-to-aws-development.yml)

#### Generate github personal access token with `repo` scope at

[Generate Github Personal Token](https://github.com/settings/tokens)


    export GITHUB_PERSONAL_ACCESS_TOKEN=<<your_personal_token>>

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-deploy-main-to-aws-development"}' \
    'https://api.github.com/repos/harishkannarao/react-nextjs-rest-api/dispatches'

#### View the running pipeline at:

[Application Pipeline](https://github.com/harishkannarao/react-nextjs-rest-api/actions)

After successful run, the application will be accessible at:

    https://http-web-development.harishkannarao.com


## Destroying environment

### Destroy environment from Github Actions Pipeline

Generate github personal access token with `repo` scope at

[Generate Github Personal Token](https://github.com/settings/tokens)

    export GITHUB_PERSONAL_ACCESS_TOKEN=<<your_personal_token>>

    curl -v -H "Accept: application/vnd.github.everest-preview+json" \
    -H "Authorization: token $GITHUB_PERSONAL_ACCESS_TOKEN" \
    --request POST \
    --data '{"event_type": "do-terraform-destroy-aws-from-master-development"}' \
    'https://api.github.com/repos/harishkannarao/github-actions-aws-terraform/dispatches'

### Destroy environment from local machine

Destroy infrastructure using terraform from local machine as described below:

[AWS terraform destroy](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_terraform_destroy.md)

## Operational Goodies

### Monitoring Dashboard and Alarms

[Monitoring Dashboard](https://eu-west-2.console.aws.amazon.com/cloudwatch/home?region=eu-west-2#dashboards:name=dashboard-docker-http-app-development)

[Alarms](https://eu-west-2.console.aws.amazon.com/cloudwatch/home?region=eu-west-2#alarmsV2:)

[Subscribe an email to SNS Notifications of Alarms](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/alarm_notify_email.md)


### Log analysis and visualization with Insights

Using Cloudwatch Logs Insights

[AWS Cloudwatch Logs Insights](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_logs_insights.md)


### Log analysis with Cloudwatch Logs

Using Cloudwatch Logs Analysis

[AWS Cloudwatch Logs Analysis](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_logs_analysis.md)


### Download logs to local machine

Download Cloudwatch Logs to local machine

[Download Cloudwatch Logs](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_logs_download.md)


### Remote monitoring ECS Fargate JVM

Monitor remote JVM using VisualVM

[VisualVM Remote JVM Monitoring](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/remote_jvm_monitoring.md)


### Local port forwarding to ECS Fargate Tasks

Local port forwarding to ECS sercice task

[Local Port Forwarding](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/local_port_forwarding.md)


### Connecting to AWS RDS instance

Connecting to remote RDS database from local

[Connecting to RDS database](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/connect_to_rds.md)


### SSH into Application Instance

SSH into ECS Fargate Service Task

[ssh into Application](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/ssh_into_application.md)


### Create terraform graphs with GraphViz

Visualize AWS Infrastructure through Terraform

[AWS Graph](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/aws_terraform_graph.md)


### Quick roll back of deployment

[Rollback a deployment](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/deployment_rollback.md)

### Copying files to bastion

[Copy files to bastion](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/copy_files_to_bastion.md)

### Get remote terraform state file

    aws s3api get-object --bucket "github-actions-ci" --key "terraform-development.tfstate" ignored/terraform-development.tfstate

### Change region and availaibility zones

Preview the changes

    grep -rn 'eu-west-2' .

Replace the region as `us-east-1`

    find . -type f -print0 | xargs -0 sed -i '' 's/eu-west-2/us-east-1/g'


### Other Terraform Commands

Validate the terraform template config and syntax

    terraform validate -json environments/$ENV_NAME


### Adhoc notes

[Other Adhoc Notes](https://github.com/harishkannarao/github-actions-aws-terraform/blob/master/docs/adhoc_notes.md)

## Cost Optimisations

The following items can be improved or optimised to reduce AWS cost per environment:

* Resue `ALB` between multiple `ECS` services using multiple `target groups` through:
    * `Host` based routing
    * `Path` based routing
* Reuse `ECS` cluster between multiple `ECS` services


## Further things to explore

* Internal ALB in private Subnets for internal services

* Deploy sample node frontend app (React / VueJS)
    * S3 Bucket
    * Cloudfront CDN
    * Custom Domain
    * HTTPS only