resource "aws_instance" "demo" {
  ami = var.ami_id
  instance_type = var.instance_type

  key_name = "dev"

  tags = {
    Name="prod"
  }
}

resource "aws_s3_bucket" "demobucket" {
  bucket = "demobucketfortf"
}

resource "aws_s3_bucket_versioning" "demoversions" {
  bucket = aws_s3_bucket.demobucket.id
  versioning_configuration {
    status = "Enabled"
  }
}