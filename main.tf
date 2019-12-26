# Require TF version to be same as or greater than 0.12.13
terraform {
  required_version = ">=0.12.13"
  backend "s3" {
    bucket         = "github-actions-ci"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "github-actions-ci-locks"
    # Optionally encrypt the state file (if encryption is enabled in s3 bucket)
    # encrypt        = true
  }
}

# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = "eu-west-2"
  version = "~> 2.36.0"
}

# resource "aws_dynamodb_table" "tf_lock_state" {
#   name = "test-dynamodb"

#   # Pay per request is cheaper for low-i/o applications, like our TF lock state
#   billing_mode = "PAY_PER_REQUEST"

#   # Hash key is required, and must be an attribute
#   hash_key = "LockID"

#   # Attribute LockID is required for TF to use this table for lock state
#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name    = "test-dynamodb"
#     BuiltBy = "Terraform"
#   }
# }