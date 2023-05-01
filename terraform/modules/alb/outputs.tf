output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "page1_target_group_arn" {
  value = aws_lb_target_group.page1.arn
}

output "page2_target_group_arn" {
  value = aws_lb_target_group.page2.arn
}

