#Creation of VPC
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "dev"
    }
}

#Creation of Subnets
resource "aws_subnet" "s1" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-1"
  }
}

resource "aws_subnet" "s2" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-2"
  }
}

#IG creation
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.name.id

    tags = {
      Name = "Cust_01"
    }
}

resource "aws_internet_gateway_attachment" "aigw" {
    internet_gateway_id = aws_internet_gateway.igw.id
    vpc_id = aws_vpc.name.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "cust_01_route"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.s1.id
    route_table_id = aws_route_table.rt.id
}

# #create private RT
# resource "aws_proute_table" "prt" {
#   vpc_id = aws_vpc.name.id

#   tags = {
#     Name = "cust_02_proute"
#   }

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws
#   }
# }

# #create Nat gateway
# resource "aws_nat_gateway" "ang" {

# }

#subnet association to private 


resource "aws_security_group" "s1_sg" {
    name = "allow_tls"
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "s1_sg"
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" #indicate all protocol
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "name" {
  ami = "ami-098e39bafa7e7303d"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.s1.id
  vpc_security_group_ids = [ aws_security_group.s1_sg.id ]

  tags = {
    Name = "dev"
  }
}
