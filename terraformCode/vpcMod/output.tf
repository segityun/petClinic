# output VPC ID as variable
output "vpc_id" {
  value = aws_vpc.vpcOne.id
}
# output public subnet to use as variable
output segment_public1 {
  value = aws_subnet.segment_public1.id
}
output "segment_public2" {
  value = aws_subnet.segment_public2.id
}
# output private subnet to use as variable
output segment_private1 {
  value = aws_subnet.segment_private1.id
}
output "segment_private2" {
  value = aws_subnet.segment_private2.id
}
output "db_subnet_group" {
  value = aws_db_subnet_group.db_subnet_group.name
}
output "public_cidr1" {
  value = aws_subnet.segment_public1.cidr_block
}
output "public_cidr2" {
  value = aws_subnet.segment_public2.cidr_block
}
output "private_cidr1" {
  value = aws_subnet.segment_private1.cidr_block
}
output "private_cidr2" {
  value = aws_subnet.segment_private2.cidr_block
}