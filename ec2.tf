data "aws_ami" "amazon_linux_2023" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
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

data "aws_key_pair" "created-key" {
  key_name           = "ec2-key-linux"
  include_public_key = true
}

resource "aws_iam_instance_profile" "role_profile" {
  name = "role_profile"
  role = aws_iam_role.base_role.name
}

resource "aws_instance" "crud-python" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type["us"]
  vpc_security_group_ids      = [aws_security_group.custom_sg.id]
  key_name                    = data.aws_key_pair.created-key.key_name
  subnet_id                   = aws_subnet.public[0].id
  iam_instance_profile        = aws_iam_instance_profile.role_profile.name
  user_data                   = file("script/user-data.sh")
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