################################################################################
# VPC
################################################################################

resource "aws_vpc" "this" {
  //count      = local.create_vpc ? 1 : 0
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

################################################################################
# Table route public
################################################################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

################################################################################
# Table route public
################################################################################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

################################################################################
# Table route associate public
################################################################################

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  #subnet_id      = aws_subnet.pub_sub_bacsystem_net.id
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

################################################################################
# Table route associate private
################################################################################

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)
  #subnet_id      = aws_subnet.pub_sub_bacsystem_net.id
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

################################################################################
# Public Subnets
################################################################################

resource "aws_subnet" "public" {
  count = length(var.subnet_public_cidr)
  vpc_id                  = aws_vpc.this.id
  cidr_block = var.subnet_public_cidr[count.index]
  #availability_zone       = var.availability_zones[count.index]
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "${var.vpc_name}-subnet-public-${count.index + 1}"
  }
}

################################################################################
# Private Subnets
################################################################################

resource "aws_subnet" "private" {
  count = length(var.subnet_private_cidr)
  vpc_id                  = aws_vpc.this.id
  cidr_block = var.subnet_private_cidr[count.index]
  #availability_zone       = var.availability_zones[count.index]
  availability_zone = element(var.availability_zones, count.index + length(var.subnet_public_cidr))
  map_public_ip_on_launch = var.map_public_ip_on_launch
  depends_on = [
    aws_subnet.public
  ]
  tags = {
    Name = "${var.vpc_name}-subnet-private-${count.index + 1}"
  }
}