# resource "aws_s3_bucket" "testdemo" {
#   bucket = "teraform-demo-state"
# }

resource "aws_instance" "named" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "dev"
  }
}
