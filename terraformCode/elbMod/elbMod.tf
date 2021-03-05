variable "security_group_id" {
  type = string
}
variable "segment_private" {
  type = string
}
variable "segment_public" {
  type = string
}

# Create a new load balancer
resource "aws_elb" "publicELB" {
  name               = "petClinicPublicELB"
  availability_zones = ["us-east-2"]
  internal = false
  load_balancer_type = "application"
  security_groups = [ var.security_group_id ]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.foo.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}