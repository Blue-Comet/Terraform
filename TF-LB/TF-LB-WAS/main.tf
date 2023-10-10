## TF-LB Main.tf

resource "aws_elb" "TF-WAS" {

  internal            = true
  name                = var.clb_name
  subnets             = var.clb_subnets
  security_groups     = var.clb_sg_name
  
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }

  tags = {
    Name = "TF-WAS"
  }
}

resource "aws_elb_attachment" "TF-CLB-EC2-Attach" {
   elb = aws_elb.TF-WAS.id
   instance = var.clb_ec2_id
}