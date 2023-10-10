## TF-LB Main.tf

resource "aws_elb" "TF-WEB" {
  name                = var.clb_name
  #availability_zones = var.clb_az
  subnets             = var.clb_subnets
  security_groups     = var.clb_sg_name
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

    listener {
    instance_port       = 443
    instance_protocol   = "http"
    lb_port             = 443
    lb_protocol         = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  tags = {
    Name = "TF-WEB"
  }
}

resource "aws_elb_attachment" "TF-CLB-EC2-Attach" {
   elb = aws_elb.TF-WEB.id
   instance = var.clb_ec2_id
}