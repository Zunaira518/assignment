locals {
  common_tags = {
    Terraform = "true"
    Project   = var.project_name
  }
}

resource "aws_launch_template" "web_server" {
  for_each      = toset(var.backend_groups)
  name_prefix   = "web_server-${each.value}"
  image_id      = var.web_server_ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    var.http_sg_id,
    var.ssh_sg_id,
  ]

  user_data = base64encode(templatefile("${path.module}/user_data.tpl", {
    content = var.content[each.value]
  }))

  tag_specifications {
    resource_type = "instance"
    tags          = local.common_tags
  }
}

resource "aws_autoscaling_group" "page" {
  for_each = toset(var.backend_groups)

  desired_capacity = var.asg_sizes[each.value].desired_capacity
  max_size         = var.asg_sizes[each.value].max_size
  min_size         = var.asg_sizes[each.value].min_size
  name_prefix      = "${each.value}-asg-"
  target_group_arns = [var.target_group_arns[each.value]]

  vpc_zone_identifier = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.web_server[each.value].id
    version = "$Latest"
  }
}
