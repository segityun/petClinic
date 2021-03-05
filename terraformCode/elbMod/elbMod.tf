variable "security_group_secGrpNginx" {
  type = string
}
variable "security_group_secGrpApp" {
  type = string
}

variable "nginxPetOne" {
  type = string
}
variable "nginxPetTwo" {
  type = string
}
variable "segment_public" {
  type = string
}
variable "segment_private" {
  type = string
}

####### Create a new Public load balancer
resource "aws_elb" "petClinicPublicELB" {
  name               = "petClinicPublicELB"
  availability_zones = ["us-east-2"]
  internal = false
  load_balancer_type = "application"
  security_groups = [ var.security_group_secGrpNginx ]
  subnets = [ var.segment_public ]
      

  listener {
    instance_port     = 80
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

  instances                   = [var.nginxPetTwo, var.nginxPetOne]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "petClinicPublicELB"
  }
}
####### Create a new PuPrivateblic load balancer
resource "aws_elb" "petClinicPrivateELB" {
  name               = "petClinicPrivateELB"
  availability_zones = ["us-east-2"]
  internal = true
  load_balancer_type = "application"
  security_groups = [ var.security_group_secGrpApp ]
  subnets = [ var.segment_private ]

  listener {
    instance_port     = 80
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

  instances                   = []
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "petClinicPrivateELB"
  }
}