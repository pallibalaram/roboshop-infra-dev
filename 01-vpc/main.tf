module "roboshop" {
  source  = "../terraform-aws-vpc"
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  vpc_tags = var.vpc_tags
  #public
  public_subnets_cidr = var.public_subnets_cidr
  #private
  private_subnets_cidr = var.private_subnets_cidr
  #database
  database_subnets_cidr = var.database_subnets_cidr
}