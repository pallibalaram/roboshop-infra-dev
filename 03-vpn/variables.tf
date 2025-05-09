variable "common_tags" {
    default = {
        Project_name = "roboshop"
        Environment = "dev"
        Terraform = "true"
    }
}
variable "project_name" {
    default = "roboshop"
}
variable "environment" {
    default = "dev"
}