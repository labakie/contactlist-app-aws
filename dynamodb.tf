# create dynamodb table
resource "aws_dynamodb_table" "contact_list" {
  name         = var.DynamoDBName
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "email"

  attribute {
    name = "email"
    type = "S"
  }
}
