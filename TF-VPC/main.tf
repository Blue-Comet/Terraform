## VPC Module Main.tf

resource "aws_vpc" "Terraform-VPC" {
  cidr_block = var.vpc_cidr_block 
  
  enable_dns_hostnames = true 

  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_internet_gateway" "TF-IGW" {
  vpc_id = aws_vpc.Terraform-VPC.id 

  tags = {
    Name = var.vpc_igw_name
  }
}

resource "aws_route_table" "Terraform-RT-EXT" {
 
  vpc_id = aws_vpc.Terraform-VPC.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TF-IGW.id
  }

  tags = {
    Name = var.vpc_route_ext_name
  }

}

resource "aws_route_table" "Terraform-RT-PRI" {

  vpc_id = aws_vpc.Terraform-VPC.id 

  tags = {
    Name = var.vpc_route_pri_name
  }

}

resource "aws_subnet" "Terraform-SBN-EXT-A" {

  vpc_id = aws_vpc.Terraform-VPC.id
  availability_zone = "us-east-1a"
  cidr_block = var.vpc_sbn_ext_a_cidr 

  tags = {
    Name = var.vpc_sbn_ext_a_name 
  }
}

resource "aws_subnet" "Terraform-SBN-EXT-C" {
  
  vpc_id = aws_vpc.Terraform-VPC.id
  availability_zone = "us-east-1c"
  cidr_block = var.vpc_sbn_ext_c_cidr 

  tags = {
    Name = var.vpc_sbn_ext_c_name 
  }
}

resource "aws_subnet" "Terraform-SBN-PRI-A" {
  
  vpc_id = aws_vpc.Terraform-VPC.id
  availability_zone = "us-east-1a"
  cidr_block = var.vpc_sbn_pri_a_cidr

  tags = {
    Name = var.vpc_sbn_pri_a_name 
  }
}

resource "aws_subnet" "Terraform-SBN-PRI-C" {
  
  vpc_id = aws_vpc.Terraform-VPC.id
  availability_zone = "us-east-1c"
  cidr_block = var.vpc_sbn_pri_c_cidr 

  tags = {
    Name = var.vpc_sbn_pri_c_name 
  }
}

resource "aws_route_table_association" "Terraform-SBN-EXT-A-Assin" {
  subnet_id      = aws_subnet.Terraform-SBN-EXT-A.id
  route_table_id = aws_route_table.Terraform-RT-EXT.id
}

resource "aws_route_table_association" "Terraform-SBN-EXT-C-Assin" {
  subnet_id      = aws_subnet.Terraform-SBN-EXT-C.id
  route_table_id = aws_route_table.Terraform-RT-EXT.id
}

resource "aws_route_table_association" "Terraform-SBN-PRI-A-Assin" {
  subnet_id      = aws_subnet.Terraform-SBN-PRI-A.id
  route_table_id = aws_route_table.Terraform-RT-PRI.id
}

resource "aws_route_table_association" "Terraform-SBN-PRI-C-Assin" {
  subnet_id      = aws_subnet.Terraform-SBN-PRI-C.id
  route_table_id = aws_route_table.Terraform-RT-PRI.id
}
