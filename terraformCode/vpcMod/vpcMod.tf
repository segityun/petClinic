# create new VPC
resource "aws_vpc" "vpcOne" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpcOne"
  }
}

# Create a Private Subnet
resource "aws_subnet" "segment_private1" {
  vpc_id     = aws_vpc.vpcOne.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.10.0/24"
  tags = {
    Name = "segment_private"
  }
}
resource "aws_subnet" "segment_private2" {
  vpc_id     = aws_vpc.vpcOne.id
  availability_zone = "us-east-2b"
  cidr_block = "10.0.11.0/24"
  tags = {
    Name = "segment_private"
  }
}


# Create a Public Subnet
resource "aws_subnet" "segment_public1" {
  vpc_id     = aws_vpc.vpcOne.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "segment_public"
  }
}
resource "aws_subnet" "segment_public2" {
  vpc_id     = aws_vpc.vpcOne.id
  availability_zone = "us-east-2b"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "segment_public"
  }
}
