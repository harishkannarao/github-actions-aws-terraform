output "test-dynamodb-id" {
  value = module.test_dynamodb.dynamo_db_table_id
}

output "test-dynamodb-arn" {
  value = module.test_dynamodb.dynamo_db_table_arn
}