# output VPC ID as variable
output "vpc_id" {
  value = aws_vpc.vpcOne.id
}
# output private subnet to use as variable
output segment_private1 {
  value = aws_subnet.segment_private1.id
}
# output public subnet to use as variable
output segment_public1 {
  value = aws_subnet.segment_public1.id
}
output "segment_public2" {
  value = aws_subnet.segment_public2.id
}
output "segment_private2" {
  value = aws_subnet.segment_private2.id
}