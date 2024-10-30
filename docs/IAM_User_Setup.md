# IAM User Setup

## Create AWS Service Roles

    aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com

    aws iam create-service-linked-role --aws-service-name ecs.application-autoscaling.amazonaws.com

    aws iam create-service-linked-role --aws-service-name elasticbeanstalk.amazonaws.com

## Create AWS IAM Group using root user or IAM adminstrator user

    aws iam create-group --group-name terraform-group

    aws iam create-group --group-name terraform-group-2

    aws iam create-group --group-name terraform-group-3

## Create a custom policy for autoscaling

Execute the command and note the created `policy arn`

```
aws iam create-policy \
    --policy-name ApplicationAutoScalingCustomPolicy \
    --policy-document \
'{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"application-autoscaling:*"
			],
			"Resource": [
				"*"
			]
		}
	]
}'
```

## Attach needed policies to IAM Group using root user or adminstrator user

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRDSFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchFullAccess --group-name terraform-group
    
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudWatchLogsFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonECS_FullAccess --group-name terraform-group

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AWSElasticBeanstalkFullAccess --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/EC2InstanceConnect --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonSNSFullAccess --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/CloudFrontFullAccess --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/SecretsManagerReadWrite --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AWSKeyManagementServicePowerUser --group-name terraform-group-2

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole --group-name terraform-group-3

    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AutoScalingFullAccess --group-name terraform-group-3

    aws iam attach-group-policy --policy-arn arn:aws:iam::{account-id}:policy/ApplicationAutoScalingCustomPolicy --group-name terraform-group-3

## Create AWS IAM User using root user or adminstrator user

    aws iam create-user --user-name terraform-user

## Attach the user to terraform user groups

    aws iam add-user-to-group --user-name terraform-user --group-name terraform-group

    aws iam add-user-to-group --user-name terraform-user --group-name terraform-group-2

    aws iam add-user-to-group --user-name terraform-user --group-name terraform-group-3

## Create access key for IAM user and note down the key id and secret access key

    aws iam create-access-key --user-name terraform-user