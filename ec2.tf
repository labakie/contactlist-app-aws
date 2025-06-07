data "aws_ami" "amazon_linux_2023" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "tf-crud-python-sg" {
  name        = "tf-crud-python-sg"
  description = "allow SSH-HTTP inbound traffic and all outbond traffic"
  vpc_id      = aws_vpc.custom_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.tf-crud-python-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.tf-crud-python-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.tf-crud-python-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

data "aws_key_pair" "created-key" {
  key_name           = "ec2-key-linux"
  include_public_key = true
}

resource "aws_iam_instance_profile" "role_profile" {
  name = "role_profile"
  role = aws_iam_role.base_role.name
}

resource "aws_instance" "crud-python" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.tf-crud-python-sg.id]
  key_name               = data.aws_key_pair.created-key.key_name
  subnet_id              = aws_subnet.public.id
  iam_instance_profile   = aws_iam_instance_profile.role_profile.name
  associate_public_ip_address = true

  tags = {
    Name = "crud-python-extid"
  }
}

output "instance-public-ip" {
  value = "http://${aws_instance.crud-python.public_ip}"
}

output "public-dns" {
  value = aws_instance.crud-python.public_dns
}