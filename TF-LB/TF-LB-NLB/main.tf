## TF-LB-NLB Main.tf

resource "aws_lb" "TF-NLB" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"
  subnets            = var.nlb_subnets

  enable_deletion_protection = true

  tags = {
    Name = var.nlb_name
  }
}

resource "aws_lb_target_group" "TF-NLB-TG" {
  name                = var.nlb_tg_name
  port                = 80
  protocol            = "TCP"
  vpc_id              = var.nlb_vpc_id
  target_type         = var.nlb_target_type
  
}

resource "aws_lb_listener" "TF-NLB-LISTENER" {
  load_balancer_arn = aws_lb.TF-NLB.arn
  port              = "80"
  protocol          = "TCP"
  #alpn_policy       = "HTTP2Preferred"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TF-NLB-TG.arn
  }
}

resource "aws_lb_target_group_attachment" "TF-NLB-TG-Attachment" {
  target_group_arn = aws_lb_target_group.TF-NLB-TG.arn
  target_id        = var.nlb_tg_attache_instance
  port             = 80
}