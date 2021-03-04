# use VPC ID as variable
variable "vpc_id" {
  type = string
}

# output security group id to use it as variable
output "security_group_id" {
       value = aws_security_group.secGrpPets.id
}
# use ingresses protocols as variables
variable "ingresses" {
  type    = list(number)
  default = [8080, 443, 22, 3306]
}

# create aws security group with MYSQL,HTTPS,SSH inbound rules
resource "aws_security_group" "secGrpPets" {
  name        = "Connections"
  description = "Allow traffic between all of the components in our network"
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
    "secGrpPets" = "true"
  }
}