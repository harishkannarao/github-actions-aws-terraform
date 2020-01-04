output "test-dynamodb-id" {
  value = module.test_dynamodb.dynamo_db_table_id
}

output "test-dynamodb-arn" {
  value = module.test_dynamodb.dynamo_db_table_arn
}

output "elastic-beanstalk-service-role-arn" {
  value = data.aws_iam_role.ebs_iam_service_role.arn
}
