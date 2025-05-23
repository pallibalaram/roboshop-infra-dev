terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1" 
    }
  }

  backend "s3" {
    bucket         = "pavandev-state-remote"
    key            = "cdn"
    region         = "us-east-1"
    dynamodb_table = "pavandev-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}