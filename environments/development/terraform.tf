terraform {
  required_version = ">=1.7.5"
  backend "s3" {
    bucket         = "github-actions-ci"
    key            = "terraform-development.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "github-actions-ci-locks"
  }

  required_providers {
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}