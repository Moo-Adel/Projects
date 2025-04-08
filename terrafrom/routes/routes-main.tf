
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "project-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_AZ1" {
  subnet_id      = var.id_subnet_public_AZ1
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_AZ2" {
  subnet_id      = var.id_subnet_public_AZ2
  route_table_id = aws_route_table.public_rt.id
}