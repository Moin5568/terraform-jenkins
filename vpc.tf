resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "moin-vpc"
    }
  }

  resource "aws_subnet" "mysub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "moin-pub-subnet"
    }
  }

  resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "moin-igw"
    }
}

resource "aws_route_table" "myroute" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id

    }
    tags = {
      Name = "moin-pub-route"
    }
}

#ASSOCIATE ROUTE TABLE WITH PUBLIC SUBNET

resource "aws_route_table_association" "route_associate" {
  subnet_id      = aws_subnet.mysub.id
  route_table_id = aws_route_table.myroute.id
}

resource "aws_security_group" "mysg" {
    vpc_id = aws_vpc.myvpc.id

    ingress  {
        from_port = 22
        to_port   = 22
        protocol  ="tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "moin-sg"
  }
  
}




