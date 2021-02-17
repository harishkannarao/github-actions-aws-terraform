provider "aws" {
  region  = var.region
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}