resource "aws_s3_bucket" "s3" {
  bucket = "test-lambda-buc-tf"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.s3.name
  key = "file"
  source = "path"

  etag = filemd5("path")
}