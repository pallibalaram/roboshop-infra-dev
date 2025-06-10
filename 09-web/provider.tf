terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2" 
    }
  }

  backend "s3" {
    bucket         = "pavandev-state-remote"
    key            = "web"
    region         = "us-east-1"
    dynamodb_table = "pavandev-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}