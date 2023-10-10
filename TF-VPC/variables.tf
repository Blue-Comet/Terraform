## VPC Module Variables.tf

variable "vpc_cidr_block" {
  type = string 
}

## var.subnet

variable "vpc_sbn_ext_a_name" {
  type = string
}

variable "vpc_sbn_ext_c_name" {
  type = string
}

variable "vpc_sbn_pri_a_name" {
  type = string
}

variable "vpc_sbn_pri_c_name" {
  type = string
}

variable "vpc_sbn_ext_a_cidr" {
  type = string
}

variable "vpc_sbn_ext_c_cidr" {
  type = string
}

variable "vpc_sbn_pri_a_cidr" {
  type = string
}

variable "vpc_sbn_pri_c_cidr" {
  type = string
}

## var.igw

variable "vpc_igw_name" {
  type = string
}

## var.route

variable "vpc_route_pri_name" {
  type = string
}

variable "vpc_route_ext_name" {
  type = string
}
