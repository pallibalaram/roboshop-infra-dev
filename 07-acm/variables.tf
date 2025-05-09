variable "common_tags" {
    default = {
        Project_name = "roboshop"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "tags" {
    default = {
        component = "acm"
    }
}

variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "zone_name" {
    default = "pavandev.online"
}