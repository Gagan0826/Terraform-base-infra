provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "terr-bucket-backend-1"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name = "My S3 Bucket"
  }
}


resource "aws_dynamodb_table" "my_table" {
  name           = "MyLockTable"
  billing_mode   = "PAY_PER_REQUEST" 
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  
  tags = {
    Name = "My DynamoDB Table"
  }
}
