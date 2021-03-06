# use VPC ID as variable
variable "vpc_id" {
  type = string
}

# use ingresses protocols as variables
variable "ingresses" {
  type    = list(number)
  default = [80, 8080]
}
