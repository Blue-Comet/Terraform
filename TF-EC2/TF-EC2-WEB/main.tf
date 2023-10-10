## EC2 Main.tf

resource "aws_instance" "TF-EC2-WEB" {
  ami           = var.ec2_ami 
  instance_type = var.ec2_instane_type
  key_name = var.ec2_keyname 
  vpc_security_group_ids = [ var.ec2_sg_id ]
  user_data = file("${path.module}/WEB.sh")
  
  subnet_id = var.ec2_subnet_id
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_root_device_size
    volume_type = var.ec2_root_device_type 
  }

  tags = {
    Name = var.ec2_name 
  }
}
