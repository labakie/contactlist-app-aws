variable "public_subnet_cidr" {
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidr" {
  type = list(string)
  default = [ "10.0.3.0/24", "10.0.4.0/24" ]
}

variable "us_zones" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "id_zones" {
  type = list(string)
  default = [ "ap-southeast-3a", "ap-southeast-3b" ]
}

variable "instance_type" {
  type = map(string)
  default = {
    "us" = "t2.micro"
    "id" = "t3.micro"
  }
}

# FOR IAM.tf
variable "PolicyName" {
  type = map(string)
  default = {
    "read" = "DynamoDBReadPolicy"
    "update" = "DynamoDBUpdatePolicy"
    "adddelete" = "DynamoDBAddDeletePolicy"
    "admin" = "DynamoDBAdminPolicy"
  }
}

variable "RoleName" {
  type = map(string)
  default = {
    "read" = "DynamoDBReadRole"
    "update" = "DynamoDBUpdateRole"
    "adddelete" = "DynamoDBAddDeleteRole"
    "admin" = "DynamoDBAdminRole"
  }
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

variable "DynamoDBName" {
  default = "ContactListTable"
}
