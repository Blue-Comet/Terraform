## Security Group Output.tf

output "output_tf_sg_elb_web_id" {
  value = aws_security_group.TF-SG-ELB-WEB.id
}