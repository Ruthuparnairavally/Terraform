# resource "aws_vpc" "demo_vpc" {
#     cidr_block = "10.0.0.0/16"

#     depends_on = [ aws_subnet.s1 ]
# }

# resource "aws_subnet" "s1" {
#   vpc_id = aws_vpc.demo_vpc.id
#   cidr_block = "10.0.0.0/24"
# }

resource "aws_instance" "name" {
  ami= "ami-098e39bafa7e7303d"
  instance_type = "t3.micro"
}

resource "aws_s3_bucket" "s3_demo" {
  bucket = "test-demo-tr-buc"
  depends_on = [ aws-instance.name ]
}