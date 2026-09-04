provider "aws" {
  region = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "webserver" {
    ami = "ami-090d68841c2a28756"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-07c392184444ea10e"]
    key_name = "key"
    tags = {
        purpose = "webserver"
    }
    count = 1
    
     }

