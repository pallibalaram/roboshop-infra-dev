terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }
    backend"s3"{
        bucket = "pavandev-state-remote"
        key = "vpc"
        region = "us-east-1"
        dynamo_table = "pavan-locking-dev"
    }
}
provider "aws" {
  region = "us-east-1"
}