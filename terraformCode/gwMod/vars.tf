#use VPC id as a variable
variable "vpc_id" {
  type = string
}
#use aws public id as a variable
variable "segment_public" {
  type = string
}

#use aws private id as a variable
variable "segment_private" {
  type = string
}
