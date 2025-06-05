# get current region
data "aws_region" "current" {}

# get EC2 base role 
data "aws_iam_role" "base_role" {
  name = "EC2DynamoDBBaseRole-1"
}

# create policy
resource "aws_iam_policy" "policy_A" {
  name        = var.Policy_A
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
resource "aws_iam_role" "role_A" {
  name        = var.Role_A
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/EC2DynamoDBBaseRole-1"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "readonly-123"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_A" {
  role       = aws_iam_role.role_A.name
  policy_arn = aws_iam_policy.policy_A.arn
}

# create policy
resource "aws_iam_policy" "policy_B" {
  name        = var.Policy_B
  description = var.IAMPolicyDesc

  policy = jsonencode(
    {
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
      ],
      "Version" : "2012-10-17"
  })
}

# create role
resource "aws_iam_role" "role_B" {
  name        = var.Role_B
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/EC2DynamoDBBaseRole-1"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "update-234"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_B" {
  role       = aws_iam_role.role_B.name
  policy_arn = aws_iam_policy.policy_B.arn
}

# create policy
resource "aws_iam_policy" "policy_C" {
  name        = var.Policy_C
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
resource "aws_iam_role" "role_C" {
  name        = var.Role_C
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/EC2DynamoDBBaseRole-1"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "adddelete-345"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_C" {
  role       = aws_iam_role.role_C.name
  policy_arn = aws_iam_policy.policy_C.arn
}

# create policy
resource "aws_iam_policy" "policy_D" {
  name        = var.Policy_D
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
resource "aws_iam_role" "role_D" {
  name        = var.Role_D
  description = var.IAMRoleDesc

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Statement1",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${var.AccountID}:role/EC2DynamoDBBaseRole-1"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "admin-456"
            }
          }
      }]
  })
}

# assign created policy to role
resource "aws_iam_role_policy_attachment" "attachment_D" {
  role       = aws_iam_role.role_D.name
  policy_arn = aws_iam_policy.policy_D.arn
}