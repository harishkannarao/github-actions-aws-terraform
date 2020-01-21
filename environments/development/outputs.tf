output "test-dynamodb-id" {
  value = "${module.test_dynamodb.dynamo_db_table_id}"
}

output "test-dynamodb-arn" {
  value = "${module.test_dynamodb.dynamo_db_table_arn}"
}

output "elastic-beanstalk-service-role-arn" {
  value = "${data.aws_iam_role.ebs_iam_service_role.arn}"
}

output "ecr-registry-id" {
  value = "${module.ecs.registry_id}"
}

output "ecr-repository-url" {
  value = "${module.ecs.repository_url}"
}

output "alb-dns-name" {
  value = "${module.ecs.alb_dns_name}"
}