resource "aws_vpc" "apps" {
  cidr_block = "172.19.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-apps-${random_string.this.result}"
  }
}

resource "aws_subnet" "apps_private1" {
  cidr_block              = "172.19.128.0/20"
  availability_zone_id    = "cac1-az1"
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.apps.id

  tags = {
    "kubernetes.io/cluster/eks-${random_string.this.result}" = "shared"
    Name                                                     = "cac1-az1-priv-${random_string.this.result}"
  }
}

resource "aws_subnet" "apps_private2" {
  cidr_block              = "172.19.144.0/20"
  availability_zone_id    = "cac1-az2"
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.apps.id

  tags = {
    "kubernetes.io/cluster/eks-${random_string.this.result}" = "shared"
    Name                                                     = "cac1-az2-priv-${random_string.this.result}"
  }
}
resource "aws_subnet" "apps_public1" {
  cidr_block           = "172.19.0.0/20"
  availability_zone_id = "cac1-az1"
  vpc_id               = aws_vpc.apps.id

  tags = {
    Name = "cac1-az1-pub-${random_string.this.result}"
  }
}
resource "aws_subnet" "apps_public2" {
  cidr_block           = "172.19.16.0/20"
  availability_zone_id = "cac1-az2"
  vpc_id               = aws_vpc.apps.id

  tags = {
    Name = "cac1-az2-pub-${random_string.this.result}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.apps.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.apps.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
  }
}


# VPC Gateways
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.apps.id
}

resource "aws_eip" "natgw" {
  vpc = true
}

resource "aws_nat_gateway" "gw" {
  subnet_id     = aws_subnet.apps_public1.id
  allocation_id = aws_eip.natgw.id
  depends_on    = [aws_internet_gateway.gw]
}
