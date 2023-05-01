resource "aws_lb" "alb" {
  name               = "assignment-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.http_sg_id]
  subnets = var.public_subnet_ids

}

resource "aws_lb_target_group" "page1" {
  name     = "page1-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "page2" {
  name     = "page2-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "page1" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.page1.arn
  }

  condition {
    path_pattern {
      values = ["/page1.html"]
    }
  }
}

resource "aws_lb_listener_rule" "page2" {
  listener_arn = aws_lb_listener.http.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.page2.arn
  }

  condition {
    path_pattern {
      values = ["/page2.html"]
    }
  }
}

