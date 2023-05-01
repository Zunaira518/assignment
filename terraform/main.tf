module "vpc" {
  source            = "./modules/vpc"
  name              = "example-vpc"
  cidr_block        = "10.0.0.0/16"
  public_subnet_cidrs =  ["10.0.1.0/24", "10.0.2.0/24"]
  region            = ""
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [
    module.vpc.public_subnet_id_1,
    module.vpc.public_subnet_id_2
  ]
  http_sg_id        = module.security_groups.http_sg_id
}

module "asg" {
  backend_groups         = ["page1", "page2"]
  source                = "./modules/asg"
  project_name          = "assignment-project"
  web_server_ami_id     = var.web_server_ami_id
  instance_type         = "t2.micro"
  key_name              = var.key_name
  http_sg_id            = module.security_groups.http_sg_id
  ssh_sg_id             = module.security_groups.ssh_sg_id
  public_subnet_ids     =[
    module.vpc.public_subnet_id_1,
    module.vpc.public_subnet_id_2
  ]
  content               = var.content
  target_group_arns = {
    page1 = module.alb.page1_target_group_arn
    page2 = module.alb.page2_target_group_arn
  }
  asg_sizes             = var.asg_sizes
}
