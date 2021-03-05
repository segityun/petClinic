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
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = var.segment_public
  route_table_id = aws_route_table.route_table_Public_gateway.id
}

# elastic ip
resource "aws_eip" "elastic_ip" {
  vpc      = true
}

# NAT gateway for public
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [
    var.segment_public,
    aws_eip.elastic_ip,
  ]
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = var.segment_public

  tags = {
    Name = "nat-gateway"
  }
}

# route table with target as NAT gateway
resource "aws_route_table" "NAT_route_table" {
  depends_on = [
    var.vpc_id,
    aws_nat_gateway.nat_gateway,
  ]

  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "NAT-route-table"
  }
}

# associate route table to private subnet
resource "aws_route_table_association" "associate_route_table_to_private_subnet" {
  depends_on = [
    var.segment_private,
    aws_route_table.NAT_route_table,
  ]
  subnet_id      = var.segment_private
  route_table_id = aws_route_table.NAT_route_table.id
}