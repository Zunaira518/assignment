variable "name" {}

variable "cidr_block" {

 }

variable "public_subnet_cidrs" {
  type = list(string)

}

variable "region" {
  description = "The AWS region where the resources will be created"
}

