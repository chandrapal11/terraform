resource "aws_dynamodb_table" "db_table" {
  name        = "${var.table_name}"
  billing_mode = "${var.table_billing_mode}"
  hash_key       = "FileName"
  attribute {
    name = "FileName"
    type = "S"
  }
}