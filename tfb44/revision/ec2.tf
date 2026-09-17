provider "aws" {
  region = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}


resource "aws_instance"  "webserver" {
     ami = "ami-098f18a6382fb4b2d"
     instance_type = "t3.micro"
     vpc_security_group_ids = ["sg-049ccf41dde8771d9"]
     key_name = "key"
     tags ={
        purpose = "webserver"
     }
count = 1
}