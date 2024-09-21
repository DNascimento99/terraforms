provider "aws" {
  region  = "us-east-1"
  default_tags { tags = var.tags }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9"
    }
  }
  backend "s3" {
    bucket  = ""
    key     = ""
    region  = ""
    profile = ""
  }
  required_version = ">=1.1.0" # Required terraform version
}

