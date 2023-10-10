## Main.tf

## VPC Create 

module "TF-VPC" {
  source		            = "./TF-VPC"
  vpc_cidr_block	      = "192.168.0.0/16"

### Create VPC Subnet

  vpc_sbn_ext_a_name	  = "TF-SBN-EXT-A"
  vpc_sbn_ext_a_cidr	  = "192.168.1.0/24" 

  vpc_sbn_ext_c_name  	= "TF-SBN-EXT-C"
  vpc_sbn_ext_c_cidr  	= "192.168.2.0/24"

  vpc_sbn_pri_a_name  	= "TF-SBN-PRI-A"
  vpc_sbn_pri_a_cidr  	= "192.168.3.0/24"

  vpc_sbn_pri_c_name  	= "TF-SBN-PRI-C"
  vpc_sbn_pri_c_cidr  	= "192.168.4.0/24"  

### Create VPC Route Table

  vpc_route_ext_name	  = "TF-VPC-RT-WEB"
  vpc_route_pri_name  	= "TF-VPC-RT-PRI"

### VPC Attach Internet Gateway
  vpc_igw_name		= "TF-VPC-IGW"

}

## Security Group Create

module "TF-SG-WEB" {
  source		            = "./TF-SG/TF-SG-WEB"
  sg_name		            = "TF-SG-EC2-WEB"
  vpc_id		            = module.TF-VPC.output_vpc_id
}

module "TF-SG-WAS" {
  source                = "./TF-SG/TF-SG-WAS"
  sg_name               = "TF-SG-EC2-WAS"
  vpc_id                = module.TF-VPC.output_vpc_id
}

module "TF-SG-ELB-WEB" {
  source                = "./TF-SG/TF-SG-ELB-WEB"
  sg_name               = "TF-SG-ELB-WEB"
  vpc_id                = module.TF-VPC.output_vpc_id
}

module "TF-SG-ELB-WAS" {
  source                = "./TF-SG/TF-SG-ELB-WAS"
  sg_name               = "TF-SG-ELB-WAS"
  vpc_id                = module.TF-VPC.output_vpc_id
}


## EC2 Create

## Create WEB EC2 

module "TF-EC2-WEB" {
  source		            = "./TF-EC2/TF-EC2-WEB"
  ec2_name		          = "TF-EC2-WEB"
  ec2_ami		            = "ami-0d5eff06f840b45e9"
  ec2_vpc_id		        = module.TF-VPC.output_vpc_id 
  ec2_subnet_id		      = module.TF-VPC.output_vpc_sbn_ext_a_id
  ec2_sg_id		          = module.TF-SG-WEB.output_tf_sg_web_id
  ec2_keyname		        = "Key_names"
  ec2_instane_type	    = "t2.micro"
  ec2_root_device_size	= "30"
  ec2_root_device_type	= "gp2"
}

### Create WAS EC2 

module "TF-EC2-WAS" {
  source                = "./TF-EC2/TF-EC2-WAS"
  ec2_name              = "TF-EC2-WAS"
  ec2_ami               = "ami-0d5eff06f840b45e9"
  ec2_vpc_id            = module.TF-VPC.output_vpc_id
  ec2_subnet_id         = module.TF-VPC.output_vpc_sbn_ext_a_id
  ec2_sg_id		          = module.TF-SG-WAS.output_tf_sg_was_id
  ec2_keyname           = "Key_names"
  ec2_instane_type      = "t2.micro"
  ec2_root_device_size  = "30"
  ec2_root_device_type  = "gp2"
}

## ELB Create

module "TF-LB-WEB" {
  source                = "./TF-LB/TF-LB-WEB"
  clb_name              = "TF-LB-WEB"
  clb_sg_name           = [ module.TF-SG-ELB-WEB.output_tf_sg_elb_web_id ]
  clb_subnets           = [ module.TF-VPC.output_vpc_sbn_ext_a_id, module.TF-VPC.output_vpc_sbn_ext_c_id ]
  clb_ec2_id            = module.TF-EC2-WEB.output_ec2_id
}

module "TF-LB-WAS" {
  source                = "./TF-LB/TF-LB-WAS"
  clb_name              = "TF-LB-WAS"
  clb_sg_name           = [ module.TF-SG-ELB-WAS.output_tf_sg_elb_was_id ]
  clb_subnets           = [ module.TF-VPC.output_vpc_sbn_pri_a_id, module.TF-VPC.output_vpc_sbn_pri_c_id ]
  clb_ec2_id            = module.TF-EC2-WAS.output_ec2_id
}

## NLB Create

module "TF-LB-NLB" {
  source                  = "./TF-LB/TF-LB-NLB"
  nlb_name                = "TF-LB-NLB"
  nlb_subnets             = [ module.TF-VPC.output_vpc_sbn_pri_a_id, module.TF-VPC.output_vpc_sbn_pri_c_id ]
  nlb_tg_name             = "TF-NLB-TargetGroup"
  nlb_vpc_id              = module.TF-VPC.output_vpc_id
  nlb_target_type         = "instance"
  nlb_tg_attache_instance = module.TF-EC2-WEB.output_ec2_id
}