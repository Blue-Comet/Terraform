## Security Group Main.tf

resource "aws_security_group" "TF-SG-ELB-WEB" {

  name        = var.sg_name
  description = "TF-SG Allow Web inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow Web from VPC"
    from_port        = "443"
    to_port          = "443"
    protocol         = "tcp"
    cidr_blocks	     = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow Web from VPC"
    from_port        = "80"
    to_port          = "80"
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
