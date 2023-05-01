output "page1_asg_id" {
  description = "The autoscaling group ID for page1"
  value       = aws_autoscaling_group.page["page1"].id
}

output "page2_asg_id" {
  description = "The autoscaling group ID for page2"
  value       = aws_autoscaling_group.page["page2"].id
}
