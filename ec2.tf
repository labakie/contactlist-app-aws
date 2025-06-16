# get ami id of amazon linux 2023 trough filtering
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

# get created key pair trough console
# data "aws_key_pair" "created_key" {
#   key_name           = "ec2-key-linux"
#   include_public_key = true
# }

# create instance profile for attach role to instance
resource "aws_iam_instance_profile" "role_profile" {
  name = "role_profile"
  role = aws_iam_role.base_role.name
}

# create an EC2 instance
resource "aws_instance" "contactlist_instance" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.custom_sg.id]
  subnet_id              = aws_subnet.public[0].id
  iam_instance_profile   = aws_iam_instance_profile.role_profile.name
  user_data = templatefile("script/user-data.sh.tftpl", {
    git_branch = var.git_branch
  })
  associate_public_ip_address = true
  # key_name                    = data.aws_key_pair.created_key.key_name

  tags = {
    Name = "Contact List Server"
  }
}

# print public ip value in terminal
output "instance_public_ip" {
  value = "https://${aws_instance.contactlist_instance.public_ip}"
}

# create A record in cloudflare
resource "cloudflare_dns_record" "contactlist_record" {
  zone_id = var.cloudflare_zone_id
  comment = "record for contact list server hosted in EC2"
  content = aws_instance.contactlist_instance.public_ip
  name    = "contact"
  proxied = true
  ttl     = 1
  type    = "A"
}