variable "profile" {
  default = "iamadmin@paredesdemo"
}

variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "iamadmin-paredesdemo"
}

variable "security_group" { 
  type = list
  default = [ "sg-02c2bad255213ff51", ]
}

variable "ami" {
  default = "ami-0b326695e023b93d5"
}
