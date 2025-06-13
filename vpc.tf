# create VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ContactList_VPC"
  }
}

# create two public subnets
resource "aws_subnet" "public" {
  # using meta-argument count
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.zones, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

# create two private subnets
resource "aws_subnet" "private" {
  # using meta-argument count
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.zones, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

# create internet gateway
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "ContactList_igw"
  }
}

# create public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  tags = {
    Name = "public route table"
  }
}

# associate public subnets with the route table
resource "aws_route_table_association" "public_associate" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# create a security group
resource "aws_security_group" "custom_sg" {
  name        = "ContactList-sg"
  description = "allow SSH-HTTP inbound traffic and all outbond traffic"
  vpc_id      = aws_vpc.custom_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.custom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}