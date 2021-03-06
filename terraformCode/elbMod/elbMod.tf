####### Create a new Public load balancer
resource "aws_lb" "petClinicPublicALB" {
  name = "petClinicPublicALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [
    var.security_group_secGrpNginx]
  subnets = [
    var.segment_public]
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
  name     = "nginx_tf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "nginx" {
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = [var.nginx_instance_id1 ,var.nginx_instance_id2]
  port             = 80
}

####### Create a new Private load balancer
resource "aws_alb" "petClinicPrivateALB" {
  name = "petClinicPrivateALB"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.security_group_secGrpApp]
  subnets = [var.segment_private]
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
  name     = "app_tf"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = [var.app_instance_id1 ,var.app_instance_id2]
  port             = 8080
}
