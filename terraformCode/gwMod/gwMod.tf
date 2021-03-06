#create new internet gateway
resource "aws_internet_gateway" "Public_gateway" {
  vpc_id = var.vpc_id
  tags = {
    name = "Public_gateway"
  }
}

#create new route table
resource "aws_route_table" "route_table_Public_gateway" {
  vpc_id = var.vpc_id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Public_gateway.id
  }
    tags = {
    Name = "route_table_Public_gateway"
  }
}

#assign the aws public subnet to the route table
resource "aws_route_table_association" "subnet-association1" {
  subnet_id      = var.segment_public1
  route_table_id = aws_route_table.route_table_Public_gateway.id
}
resource "aws_route_table_association" "subnet-association2" {
  subnet_id      = var.segment_public2
  route_table_id = aws_route_table.route_table_Public_gateway.id
}

# elastic ip
resource "aws_eip" "elastic_ip1" {
  vpc      = true
}

# NAT gateway for public
resource "aws_nat_gateway" "nat_gateway1" {
  depends_on = [var.segment_public1, aws_eip.elastic_ip1,]
  allocation_id = aws_eip.elastic_ip1.id
  subnet_id     = var.segment_public1

  tags = {
    Name = "nat-gateway"
  }
}

# route table with target as NAT gateway
resource "aws_route_table" "NAT_route_table1" {
  depends_on = [var.vpc_id, aws_nat_gateway.nat_gateway1]
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway1.id
  }

  tags = {
    Name = "NAT-route-table"
  }
}

# associate route table to private subnet
resource "aws_route_table_association" "associate_route_table_to_private_subnet1" {
  depends_on = [var.segment_private1, aws_route_table.NAT_route_table1,]
  subnet_id      = var.segment_private1
  route_table_id = aws_route_table.NAT_route_table1.id
}


# elastic ip
resource "aws_eip" "elastic_ip2" {
  vpc      = true
}

# NAT gateway for public
resource "aws_nat_gateway" "nat_gateway2" {
  depends_on = [var.segment_public2, aws_eip.elastic_ip2,]
  allocation_id = aws_eip.elastic_ip2.id
  subnet_id     = var.segment_public2

  tags = {
    Name = "nat-gateway"
  }
}

# route table with target as NAT gateway
resource "aws_route_table" "NAT_route_table2" {
  depends_on = [var.vpc_id, aws_nat_gateway.nat_gateway2,]
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway2.id
  }

  tags = {
    Name = "NAT-route-table"
  }
}

# associate route table to private subnet
resource "aws_route_table_association" "associate_route_table_to_private_subnet2" {
  depends_on = [var.segment_private2, aws_route_table.NAT_route_table2,]
  subnet_id      = var.segment_private2
  route_table_id = aws_route_table.NAT_route_table2.id
}