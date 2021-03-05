#using aws public and security group ID as variables
variable "segment_public" {
  type = string
}
variable "security_group_id" {
  type = string
}
variable "file" {}