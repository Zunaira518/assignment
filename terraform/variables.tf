variable "web_server_ami_id" {
  description = "The AMI ID of the web server"
  default = ""
}

variable "key_name" {
  description = "The name of the key pair for the instances"
  default = ""
}

variable "content" {
  type        = map(string)
  description = "The content for each backend"
  default = {
  "page1" = "<html><head><title>Page 1</title></head><body><h1>Welcome to Page 1</h1></body></html>"
  "page2" = "<html><head><title>Page 2</title></head><body><h1>Welcome to Page 2</h1></body></html>"
}
}

variable "asg_sizes" {
  description = "Min and max sizes for the autoscaling groups"
  type = map(object({
    min_size = number
    max_size = number
    desired_capacity = number
  }))
  default = {
    page1 = {
      desired_capacity = 1
      min_size = 1
      max_size = 2
    }
    page2 = {
      desired_capacity = 1    
      min_size = 1
      max_size = 2
    }
  }
}

