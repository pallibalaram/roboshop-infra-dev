locals {
    name = "${var.project_name}-${var.environment}"
    current_time = formatdate("DD-MMM-YYYY-hh-mm", timestamp())
}