provider "aws" {
  region = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}


resource "aws_instance" "webserver" {
    ami = "ami-0bdc7d025135d7b49"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-0dce926e31d5c67c1"]
    key = "key"
    tags = {
        purpose = "webserver"
    }
    count =2
}