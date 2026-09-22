provider "aws" {
  region = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}


resource "aws_instance"  "webserver" {
     ami = "ami-066c4849e6b3a1e3d"
     instance_type = "t3.micro" 
     vpc_security_group_ids = ["sg-09352767190d70e24"]
     key_name = "key"
     tags ={
        purpose = "webserver"
     }
     count= 1
}