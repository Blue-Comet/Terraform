## TF-EC2 Output.tf


output "output_ec2_id" {
  value = aws_instance.TF-EC2-WAS.id
}
