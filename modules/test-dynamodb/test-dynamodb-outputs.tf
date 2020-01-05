output "dynamo_db_table_id" {
  value = "${aws_dynamodb_table.test-dynamodb.id}"
}

output "dynamo_db_table_arn" {
  value = "${aws_dynamodb_table.test-dynamodb.arn}"
}
