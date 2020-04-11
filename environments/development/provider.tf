# Download any stable version in AWS provider of 2.36.0 or higher in 2.36 train
provider "aws" {
  region  = var.region
  version = "~> 2.36.0"
}