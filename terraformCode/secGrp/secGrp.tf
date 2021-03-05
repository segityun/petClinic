
##### First security Group
# create aws security group with http inbound rules
resource "aws_security_group" "secGrpNginx" {
  name        = "secGrpNginx"
  description = "Allow traffic between users to our nginx servers"
  vpc_id      = var.vpc_id

# add dynamic ingress rules list
 dynamic "ingress" {
    iterator = port
    for_each = var.ingresses
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "secGrpNginx" = "true"
  }
}

##### Second security Group
# create aws security group with http inbound rules
resource "aws_security_group" "secGrpApp" {
  name        = "secGrpApp"
  description = "Allow traffic between nginx VM to App VM"
  vpc_id      = var.vpc_id

# add dynamic ingress rules list
 dynamic "ingress" {
    iterator = port
    for_each = var.ingresses
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["10.0.1.0/24"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "secGrpApp" = "true"
  }
}


##### Third security Group
# create aws security group with http inbound rules
resource "aws_security_group" "secGrpRDS" {
  name        = "secGrpRDS"
  description = "Allow traffic between nginx VM to App VM"
  vpc_id      = var.vpc_id

# add dynamic ingress rules list
 dynamic "ingress" {
    iterator = port
    for_each = var.ingresses
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["10.0.2.0/24"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "secGrpRDS" = "true"
  }
}
