#using aws public and security group ID as variables
variable "segment_public1" {
  type = string
}
variable "segment_public2" {}
variable "security_group_id" {
  type = string
}
variable "file" {}