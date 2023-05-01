variable "vpc_id" {}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "http_sg_id" {}

