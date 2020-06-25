provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group
}

