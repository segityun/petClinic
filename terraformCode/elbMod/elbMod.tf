####### Create a new Public load balancer
resource "aws_lb" "petClinicPublicALB" {
  name = "petClinicPublicALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [
    var.security_group_secGrpNginx]
  subnets = [var.segment_public1 ,var.segment_public2]
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.petClinicPublicALB.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}
resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "nginx1" {
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = var.nginx_instance_id1
  port             = 80
}
resource "aws_lb_target_group_attachment" "nginx2" {
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id = var.nginx_instance_id2
  port = 80
}
####### Create a new Private load balancer
resource "aws_alb" "petClinicPrivateALB" {
  name = "petClinicPrivateALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.security_group_secGrpApp]
  subnets = [var.segment_private1 ,var.segment_private2]
}
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.petClinicPublicALB.arn
  port = "8080"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "app1" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = var.app_instance_id1
  port             = 8080
}
resource "aws_lb_target_group_attachment" "app2" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = var.app_instance_id2
  port             = 8080
}