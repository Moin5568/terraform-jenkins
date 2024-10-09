data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

#CREATE A EC2 INSTANCE
resource "aws_instance" "jenkins-server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = "moin-key"
    subnet_id = aws_subnet.mysub.id
    vpc_security_group_ids = [aws_security_group.mysg.id]
    availability_zone = "ap-south-1a"
    associate_public_ip_address = true
    user_data = file("jenkins.sh")
 tags = {
    Name = "moin-ec2"
 }   
  
}

# Create Elastic IP address
resource "aws_eip" "example" {
  instance = aws_instance.jenkins-server.id  # Associate with an EC2 instance (if desired)
  
  tags = {
    Name = "MyElasticIP"
  }
}
 