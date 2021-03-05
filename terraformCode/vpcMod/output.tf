# output VPC ID as variable
output "vpc_id" {
  value = aws_vpc.vpcOne.id
}
# output private subnet to use as variable
output segment_private {
  value = aws_subnet.segment_private.id
}
# output public subnet to use as variable
output segment_public {
  value = aws_subnet.segment_public.id
}