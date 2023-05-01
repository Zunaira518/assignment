source "amazon-ebs" "ubuntu" {
  ami_name      = "ami-linux-nginx"
  instance_type = "t2.micro"
  region        = "us-east-1"
  subnet_id = "subnet-id"
  ssh_keypair_name     = "packer"
  ssh_private_key_file = "packer.pem key path"
  vpc_id = "vpc-58e15225"
  associate_public_ip_address = true
  source_ami_filter {
    filters = {
      architecture        = "x86_64"    
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}


build {
  name = "ami-linux-nginx"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo touch /var/www/html/index.html",
      "sudo chown -R $USER:$USER /var/www/html",
      "sudo echo 'Hello, World!' > /var/www/html/index.html"
    ]
  }
}


