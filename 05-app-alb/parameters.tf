data "aws_ssm_parameter" "app_alb_listener_arn" {
   value = "/${var.project_name}/${var.environment}/app_alb_listener_arn" 
   type = "string"
   value = aws_lb_listener.http.arn
}