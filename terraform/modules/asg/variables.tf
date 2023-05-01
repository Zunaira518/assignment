variable "project_name" {}

variable "web_server_ami_id" {}

variable "instance_type" {}

variable "key_name" {}

variable "http_sg_id" {}

variable "ssh_sg_id" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "content" {
  type = map(string)
}

variable "backend_groups" {
  type = list(string)
  description = "The backend group (page1 or page2)"
}

variable "target_group_arns" {
  type = map(string)
  description = ""
}

variable "asg_sizes" {
  description = "Min, max, and desired capacities for the autoscaling groups"
  type = map(object({
    desired_capacity = number
    min_size         = number
    max_size         = number
  }))
}


