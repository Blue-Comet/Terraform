## TF-LB variables.tf

variable "clb_name" {
  type = string 
}

variable "clb_subnets" {
  type = list(string)
}

variable "clb_ec2_id" {
    type = string
}

variable "clb_sg_name" {
  type = list(string)
}