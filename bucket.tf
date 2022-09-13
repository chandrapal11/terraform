resource "aws_s3_bucket" "bucket" {
    bucket = "test-bucket"   
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}