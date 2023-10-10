## VPC Moudle Output.tf

output "output_vpc_id" {
  value = aws_vpc.Terraform-VPC.id
}

output "output_vpc_sbn_ext_a_id" {
  value = aws_subnet.Terraform-SBN-EXT-A.id
}

output "output_vpc_sbn_ext_c_id" {
  value = aws_subnet.Terraform-SBN-EXT-C.id
}

output "output_vpc_sbn_pri_a_id" {
  value = aws_subnet.Terraform-SBN-PRI-A.id
}

output "output_vpc_sbn_pri_c_id" {
  value = aws_subnet.Terraform-SBN-PRI-A.id
}