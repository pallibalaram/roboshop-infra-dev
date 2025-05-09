data "aws_ssm_parameter" "acm_certificate_arn" {
    name = "${var.project_name}/${var.environment}/acm_certificate_arn"
    type = "string" 
    value = aws_acm_certificate.pavandev.arn
}