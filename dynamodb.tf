# create dynamodb table
resource "aws_dynamodb_table" "user_identity" {
  name         = var.DynamoDBName
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "email"

  attribute {
    name = "email"
    type = "S"
  }
}
