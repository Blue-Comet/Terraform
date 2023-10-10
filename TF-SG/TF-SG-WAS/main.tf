## Security Group Main.tf

resource "aws_security_group" "TF-SG-WAS" {

  name        = var.sg_name
  description = "TF-SG Allow Was inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow Was from VPC"
    from_port        = "8080"
    to_port          = "8080"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sg_name
  }
}

