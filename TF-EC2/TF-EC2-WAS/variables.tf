## EC2 Module Variable.tf

variable "ec2_name" {
  type = string
}

variable "ec2_vpc_id" {
  type = string
}

variable "ec2_ami" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "ec2_keyname" {
  type = string
}

variable "ec2_instane_type" {
  type = string
}

variable "ec2_subnet_id" {
  type = string
}

variable "ec2_root_device_size" {
  type = string
}

variable "ec2_root_device_type" {
  type = string
}
