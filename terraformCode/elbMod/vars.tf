variable "security_group_secGrpNginx" {
  type = string
}
variable "security_group_secGrpApp" {
  type = string
}
variable "segment_public" {
  type = string
}
variable "segment_private" {
  type = string
}
variable "vpc_id" {}
variable "nginx_instance_id1" {}
variable "nginx_instance_id2" {}
variable "app_instance_id1" {}
variable "app_instance_id2" {}