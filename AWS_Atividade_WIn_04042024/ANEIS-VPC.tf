
# VPC
resource "aws_vpc" "ANEIS-VPC" {
  cidr_block           = "172.18.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "ANEIS-VPC"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "IGW-ANEIS" {
  vpc_id = aws_vpc.ANEIS-VPC.id

  tags = {
    Name = "IGW-ANEIS"
  }
}

# SUBNET Subrede-Pub1
resource "aws_subnet" "SubRede-Pub1" {
  vpc_id                  = aws_vpc.ANEIS-VPC.id
  cidr_block              = "172.18.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "SubRede-Pub1"
  }
}

# SUBNET Subrede-Pub2
resource "aws_subnet" "SubRede-Pub2" {
  vpc_id                  = aws_vpc.ANEIS-VPC.id
  cidr_block              = "172.18.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "SubRede-Pub2"
  }
}

# SUBNET Subrede-Pri1
resource "aws_subnet" "SubRede-Pri1" {
  vpc_id            = aws_vpc.ANEIS-VPC.id
  cidr_block        = "172.18.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SubRede-Pri1"
  }
}

# SUBNET Subrede-Pri2
resource "aws_subnet" "SubRede-Pri2" {
  vpc_id            = aws_vpc.ANEIS-VPC.id
  cidr_block        = "172.18.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SubRede-Pri2"
  }
}

# ROUTE TABLE Publica
resource "aws_route_table" "Rotas-ANEIS-Pub" {
  vpc_id = aws_vpc.ANEIS-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-ANEIS.id
  }

  tags = {
    Name = "Rotas-ANEIS-Pub"
  }
}

# ROUTE TABLE Privada
resource "aws_route_table" "Rotas-ANEIS-Pri" {
  vpc_id = aws_vpc.ANEIS-VPC.id

  tags = {
    Name = "Rotas-ANEIS-Pri"
  }
}

# SUBNET ASSOCIATION Pub
resource "aws_route_table_association" "SubRede-Pub1" {
  subnet_id      = aws_subnet.SubRede-Pub1.id
  route_table_id = aws_route_table.Rotas-ANEIS-Pub.id
}
# SUBNET ASSOCIATION Pub
resource "aws_route_table_association" "SubRede-Pub2" {
  subnet_id      = aws_subnet.SubRede-Pub2.id
  route_table_id = aws_route_table.Rotas-ANEIS-Pub.id
}