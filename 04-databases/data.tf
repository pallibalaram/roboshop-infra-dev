data "aws_ami" "centos8"{
    owners = ["973714476881"]
    most_recent      = true

    filter {
        name   = "name"
        values = ["Centos-8-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "mongodb_sg_id" {
    value = "/${var.project_name}/${var.environment}/mongodb_sg_id"
}

data "aws_ssm_parameter" "redis_sg_id" {
    value = "/${var.project_name}/${var.environment}/redis_sg_id"
}

data "aws_ssm_parameter" "mysql_sg_id" {
    value = "/${var.project_name}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
    value = "/${var.project_name}/${var.environment}/rabbitmq_sg_id"
}


data "aws_vpc" "default" {
    default = true
}