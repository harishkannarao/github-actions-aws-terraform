# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "eu-west-2"
  version = "~> 2.36.0"
}

# Call the seed_module to build our ADO seed info
module "bootstrap" {
  source                      = "../modules/bootstrap"
  name_of_s3_bucket           = "github-actions-ci"
  dynamo_db_table_name        = "github-actions-ci-locks"
}