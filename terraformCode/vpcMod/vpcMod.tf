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
    Name = "segment_private1"
  }
}
resource "aws_subnet" "segment_private2" {
  vpc_id     = aws_vpc.vpcOne.id
  availability_zone = "us-east-2b"
  cidr_block = "10.0.11.0/24"
  tags = {
    Name = "segment_private2"
  }
}


# Create a Public Subnet
resource "aws_subnet" "segment_public1" {
  vpc_id     = aws_vpc.vpcOne.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "segment_public1"
  }
}
resource "aws_subnet" "segment_public2" {
  vpc_id     = aws_vpc.vpcOne.id
  availability_zone = "us-east-2b"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "segment_public2"
  }
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.segment_private1.id, aws_subnet.segment_private2.id]

  tags = {
    Name = "db_subnet_group"
  }
}