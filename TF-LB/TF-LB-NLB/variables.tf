## TF-LB-NLB variables.tf

variable "nlb_name" {
  type = string 
}

variable "nlb_subnets" {
  type = list(string)
}

variable "nlb_tg_name" {
  type = string
}

variable "nlb_vpc_id" {
  type = string
}

variable "nlb_target_type" {
  type = string  
}

variable "nlb_tg_attache_instance" {
  type = string
}