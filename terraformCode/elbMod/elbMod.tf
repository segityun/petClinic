variable "segment_private" {
  type = string
}
variable "segment_public" {
  type = string
}

#creating the first load balancer to balance the users traffic
resource "aws_lb" "usersLB" {
  name               = "usersLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.public.segment_public.id

  tags = {
    Environment = "production"
  }
}
#creating the second load balancer to balance the traffic between the app servers
resource "aws_lb" "appLB" {
  name               = "appLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.private.segment_private.id

  tags = {
    Environment = "production"
  }
}