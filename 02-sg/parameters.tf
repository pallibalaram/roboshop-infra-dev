data "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project_name}/${var.environment}/mongodb_sg_id"
    type = "string"
    value = module.mongodb.sg_id
}

data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project_name}/${var.environment}/redis_sg_id"
    type = "string"
    value = module.redis.sg_id
}

data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project_name}/${var.environment}/mysql_sg_id"
    type = "string"
    value = module.mysql.sg_id
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project_name}/${var.environment}/rabbitmq_sg_id"
    type = "string"
    value = module.rabbitmq.sg_id
}

data "aws_ssm_parameter" "catalogue_sg_id" {
    name = "/${var.project_name}/${var.environment}/catalogue_sg_id"
    type = "string"
    value = module.catalogue.sg_id
}

data "aws_ssm_parameter" "user_sg_id" {
    name = "/${var.project_name}/${var.environment}/user_sg_id"
    type = "string"
    value = module.user.sg_id
}

data "aws_ssm_parameter" "cart_sg_id" {
    name = "/${var.project_name}/${var.environment}/cart_sg_id"
    type = "string"
    value = module.cart.sg_id
}

data "aws_ssm_parameter" "payment_sg_id" {
    name = "/${var.project_name}/${var.environment}/payment_sg_id"
    type = "string"
    value = module.payment.sg_id
}

data "aws_ssm_parameter" "shipping_sg_id" {
    name = "/${var.project_name}/${var.environment}/shipping_sg_id"
    type = "string"
    value = module.shipping.sg_id
}

data "aws_ssm_parameter" "web_sg_id" {
    name = "/${var.project_name}/${var.environment}/web_sg_id"
    type = "string"
    value = module.web.sg_id
}

data "aws_ssm_parameter" "app_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/app_alb_sg_id"
    type = "string"
    value = module.app_alb.sg_id
}

data "aws_ssm_parameter" "web_alb_sg_id" {
    name = "/${var.project_name}/${var.environment}/web_alb_sg_id"
    type = "string"
    value = module.web_alb.sg_id
}