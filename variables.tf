variable "public_subnet_cidr" {
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidr" {
  type = list(string)
  default = [ "10.0.3.0/24", "10.0.3.0/24" ]
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

variable "DynamoDBName" {
  default = "ContactListTable"
}

# FOR IAM.tf
variable "Policy_A" {
  default = "DynamoDBReadPolicy"
}

variable "Policy_B" {
  default = "DynamoDBUpdatePolicy"
}

variable "Policy_C" {
  default = "DynamoDBAddDeletePolicy"
}

variable "Policy_D" {
  default = "DynamoDBAdminPolicy"
}

variable "Role_A" {
  default = "DynamoDBReadRole"
}

variable "Role_B" {
  default = "DynamoDBUpdateRole"
}

variable "Role_C" {
  default = "DynamoDBAddDeleteRole"
}

variable "Role_D" {
  default = "DynamoDBAdminRole"
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
