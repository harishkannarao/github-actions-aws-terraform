module "test_dynamodb" {
  source                      = "../../modules/test-dynamodb"
  dynamo_db_table_name        = "test-dynamodb"
}

output "test-dynamodb-id" {
  value = module.test_dynamodb.dynamo_db_table_id
}

output "test-dynamodb-arn" {
  value = module.test_dynamodb.dynamo_db_table_arn
}
