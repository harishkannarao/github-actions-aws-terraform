module "test-dynamodb" {
  source                      = "../../modules/test-dynamodb"
  dynamo_db_table_name        = "test-dynamodb"
}