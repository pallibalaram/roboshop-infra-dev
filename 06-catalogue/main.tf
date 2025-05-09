resource "aws_lb_target_group "web" {
  name     = "${local.name}-"${var.tags.component}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value
  health_check {
      healthy_threshold   = 2
      interval            = 5
      unhealthy_threshold = 3
      timeout             = 10
      path                = "/path"
      port                = 8080
      matcher = "200-299"
  }
}

module "web" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.centos8.id
  name = "${local.name}-"${var.tags.component}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["data.aws_ssm_parameter.catalogue_sg_id.value"]
  subnet_id              = element(split(",", data.aws_ssm_parameter.private_subnet_ids),0)
  tags = merge (
    var.common_tags,
    var.tags
  )
}

resource "null_resource" "web" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.web.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.web.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }
  provisioner "file" {
    source = "/bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue dev"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ null_resource.catalogue ]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.name}-${var.tags.component}-${local.current_time}"
  source_instance_id = module.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
}

resource "null_resource" "catalogue_delete" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.catalogue.id
  }
  
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${module.catalogue.id}"
  }
  depends_on = [aws_ami_fom_instance.catalogue]
}

resource "aws_launch_template" "catalogue" {
  name = "${local.name}-${var.tags.component}"
  image_id = aws_ami_from_instance.catalogue.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  update_default_version = true
  vpc_security_group_ids = ["data.aws_ssm_parameter.catalogue_sg_id.value"]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.name}-${var.tags.component}"
    }
  }
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.name}-${var.tags.component}"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  vpc_zone_identifier       = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  target_group_arns = [ aws_lb_target_group.catalogue.arn ]
  
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "aws_launch_template.catalogue.latest_version"
  }
    instance_refresh {
      strategy = "Rolling"
      preferences {
        min_healthy_percentage = 50
      }
      triggers = ["launch_template"]
  }

  tag {
    key                 = "name"
    value               = "${local.name}-app-${var.tags.component}"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = data.aws_ssm_parameter.app_alb_listener_arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  
  condition {
    path_pattern {
      values = ["${var.tags.component}.app-${var.environment}.${var.zone_name}"]
    }
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = "aws_autoscaling_group.catalogue.name"
  name                   = "${local.name}-${var.tags.component}"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_load_metric_specification {
        predefined_metric_type = "ASGTotalCPUUtilization"
        target_value = 5.0
      }
    }
  }