resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    name = "${var.app_name}-vpc"
  }
}

resource "aws_subnet" "subnet_publica" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_pub_cidr_block
  availability_zone = var.zone_subnet
  tags = {
    name = "${var.app_name}-Publica"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "subnet_privada" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_priv_cidr_block
  availability_zone = var.zone_subnet
  tags = {
    name = "${var.app_name}-privado"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "${var.app_name}-gw"
  }
  depends_on = [aws_vpc.vpc]
}

resource "aws_security_group" "securit_group" {
  name = "${var.app_name}-sg"
  description = "Allow tcp 80 & tcp 22"
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "alow tcp 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0 
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_vpc.vpc]
}

data "aws_route_table" "main_route" {
  filter {
    name = "association.main"
    values = ["true"]
  }
  filter {
    name = "vpc-id"
    values = [aws_vpc.vpc.id]
  }
}

resource "aws_default_route_table" "internet_route" {
  default_route_table_id = data.aws_route_table.main_route.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    name = "${var.app_name}-internet" 
  }
}


resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.securit_group.id]
  subnets            = [aws_subnet.subnet_publica.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}