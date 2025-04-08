resource "aws_subnet" "public-subnet-AZ1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_subnet_public_AZ1
  map_public_ip_on_launch = true  # Enables auto-assignment of public IP
  availability_zone = var.AZ1


  tags = {
    Name = "public-subnet-AZ1"
  }
}




resource "aws_subnet" "private-subnet-AZ1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_subnet_private_AZ1
  map_public_ip_on_launch = false  
  availability_zone = var.AZ1


  tags = {
    Name = "private-subnet-AZ1"
  }
}

resource "aws_subnet" "public-subnet-AZ2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_subnet_public_AZ2
  map_public_ip_on_launch = true  # Enables auto-assignment of public IP
  availability_zone = var.AZ2


  tags = {
    Name = "public-subnet-AZ2"
  }
}

resource "aws_subnet" "private-subnet-AZ2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_subnet_private_AZ2
  map_public_ip_on_launch = false  
  availability_zone = var.AZ2


  tags = {
    Name = "private-subnet-AZ2"
  }
}