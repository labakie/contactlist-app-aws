# for vpc.tf
variable "public_subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# for ec2.tf
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# for dynamodb.tf
variable "DynamoDBName" {
  default = "ContactListTable"
}

# for iam.tf
variable "PolicyName" {
  type = map(string)
  default = {
    "read"      = "DynamoDBReadPolicy"
    "update"    = "DynamoDBUpdatePolicy"
    "adddelete" = "DynamoDBAddDeletePolicy"
    "admin"     = "DynamoDBAdminPolicy"
  }
}

variable "RoleName" {
  type = map(string)
  default = {
    "read"      = "DynamoDBReadRole"
    "update"    = "DynamoDBUpdateRole"
    "adddelete" = "DynamoDBAddDeleteRole"
    "admin"     = "DynamoDBAdminRole"
  }
}

variable "ExternalID" {
  type      = map(string)
  sensitive = true
}

variable "IAMPolicyDesc" {
  default = "Custom IAM policy Terraform."
}

variable "IAMRoleDesc" {
  default = "Custom IAM role Terraform."
}

variable "AccountID" {
  default = "478669179634"
}

# for cloudflare
variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}

# for providers.tf
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# for user-data.sh and ec2.tf
variable "git_branch" {
  type    = string
  default = "main"
}