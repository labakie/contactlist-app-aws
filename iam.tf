# get current region
data "aws_region" "current" {}

# create policy
resource "aws_iam_policy" "policy_read" {
  name        = var.PolicyName["read"]
  description = var.IAMPolicyDesc

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query"
          ],
          "Resource" : "arn:aws:dynamodb:${data.aws_region.current.name}:${var.AccountID}:table/${var.DynamoDBName}"
        },
        {
          "Sid" : "VisualEditor1",
          "Effect" : "Allow",
          "Action" : "dynamodb:ListTables",
          "Resource" : "*"
        }
      ]
  })
}

# create role
resource "aws_iam_role" "role_read" {
  name        = var.RoleName["read"]
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/DynamoDBBaseRole"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "${var.ExternalID["read"]}"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_read" {
  role       = aws_iam_role.role_read.name
  policy_arn = aws_iam_policy.policy_read.arn
}

# create policy
resource "aws_iam_policy" "policy_update" {
  name        = var.PolicyName["update"]
  description = var.IAMPolicyDesc

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query",
            "dynamodb:UpdateItem"
          ],
          "Effect" : "Allow",
          "Resource" : "arn:aws:dynamodb:${data.aws_region.current.name}:${var.AccountID}:table/${var.DynamoDBName}",
          "Sid" : "VisualEditor0"
        },
        {
          "Action" : "dynamodb:ListTables",
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : "VisualEditor1"
        }
      ]
  })
}

# create role
resource "aws_iam_role" "role_update" {
  name        = var.RoleName["update"]
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/DynamoDBBaseRole"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "${var.ExternalID["update"]}"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_update" {
  role       = aws_iam_role.role_update.name
  policy_arn = aws_iam_policy.policy_update.arn
}

# create policy
resource "aws_iam_policy" "policy_adddelete" {
  name        = var.PolicyName["adddelete"]
  description = var.IAMPolicyDesc

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem"
          ],
          "Resource" : "arn:aws:dynamodb:${data.aws_region.current.name}:${var.AccountID}:table/${var.DynamoDBName}"
        },
        {
          "Sid" : "VisualEditor1",
          "Effect" : "Allow",
          "Action" : "dynamodb:ListTables",
          "Resource" : "*"
        }
      ]
  })
}

# create role
resource "aws_iam_role" "role_adddelete" {
  name        = var.RoleName["adddelete"]
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/DynamoDBBaseRole"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "${var.ExternalID["adddelete"]}"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_adddelete" {
  role       = aws_iam_role.role_adddelete.name
  policy_arn = aws_iam_policy.policy_adddelete.arn
}

# create policy
resource "aws_iam_policy" "policy_admin" {
  name        = var.PolicyName["admin"]
  description = var.IAMPolicyDesc

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem",
            "dynamodb:UpdateItem"
          ],
          "Resource" : "arn:aws:dynamodb:${data.aws_region.current.name}:${var.AccountID}:table/${var.DynamoDBName}"
        },
        {
          "Sid" : "VisualEditor1",
          "Effect" : "Allow",
          "Action" : "dynamodb:ListTables",
          "Resource" : "*"
        }
      ]
  })
}

# create role
resource "aws_iam_role" "role_admin" {
  name        = var.RoleName["admin"]
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/DynamoDBBaseRole"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "${var.ExternalID["admin"]}"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_admin" {
  role       = aws_iam_role.role_admin.name
  policy_arn = aws_iam_policy.policy_admin.arn
}

# create policy
resource "aws_iam_policy" "base_policy" {
  name        = "DynamoDBBasePolicy"
  description = "Base policy Terraform."

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Resource" : [
            "${aws_iam_role.role_read.arn}",
            "${aws_iam_role.role_update.arn}",
            "${aws_iam_role.role_adddelete.arn}",
            "${aws_iam_role.role_admin.arn}"
          ]
        },
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Action" : "ssm:GetParameter",
          "Resource" : "arn:aws:ssm:${data.aws_region.current.name}:${var.AccountID}:parameter/deploy/github_token"
        }
    ] }
  )
}

# create role
resource "aws_iam_role" "base_role" {
  name        = "DynamoDBBaseRole"
  description = "Base role Terraform."

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
    ] }
  )
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "base_attachment" {
  role       = aws_iam_role.base_role.name
  policy_arn = aws_iam_policy.base_policy.arn
}