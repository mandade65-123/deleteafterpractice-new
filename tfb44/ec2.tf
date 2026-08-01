provider "aws" {
  region = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance"  "webserver" {
     ami = "ami-00d2dbb426772b03a"
     instance_type = "t3.micro"
     vpc_security_group_ids = ["sg-05e7e2c67090bfab2"]
     key_name = "key"
     tags ={
        purpose = "webserver"
     }
     count= 2
}