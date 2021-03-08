# use VPC ID as variable
variable "vpc_id" {
  type = string
}

# use ingresses protocols as variables
variable "ingresses" {
  type    = list(number)
  default = [80, 8080, 22]
}
variable "public_cidr1" {}
variable "public_cidr2" {}
variable "private_cidr1" {}
variable "private_cidr2" {}