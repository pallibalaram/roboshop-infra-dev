data "aws_ssm_parameter" "app_alb_sg_id" {
    value = "/${var.project_name}/${var.environment}/app_alb_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
    value = "/${var.project_name}/${var.environment}/private_subnet_ids"
}
