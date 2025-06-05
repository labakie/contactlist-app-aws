# variable "PolicyName" {
#   default = "CustomLambdaToDynamoDBPolicy"
# }

# variable "PolicyDescription" {
#   default = "Policy for access dynamodb and enable log from function."
# }

# variable "RoleName" {
#   default = "CustomLambdaToDynamoDBRole"
# }

# variable "RoleDescription" {
#   default = "Role for Lambda."
# }

# variable "LambdaName" {
#   default = "IdentityFunction"
# }

variable "DynamoDBName" {
  default = "UserIdentityTable"
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
