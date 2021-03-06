#use VPC id as a variable
variable "vpc_id" {
  type = string
}
#use aws public id as a variable
variable "segment_public1" {}
variable "segment_public2" {
  type = string
}

#use aws private id as a variable

variable "segment_private1" {}
variable "segment_private2" {
  type = string
}
