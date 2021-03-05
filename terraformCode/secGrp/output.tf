# output security group id to use it as variable
output "security_group_secGrpNginx" {
  value = aws_security_group.secGrpNginx.id
}
# output security group id to use it as variable
output "security_group_secGrpApp" {
  value = aws_security_group.secGrpApp.id
}
# output security group id to use it as variable
output "security_group_secGrpRDS" {
  value = aws_security_group.secGrpRDS.id
}