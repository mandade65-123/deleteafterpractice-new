provider "aws" {
  region = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
} 



resource "aws_instance" "webserver" {
  ami           = "ami-004f790b835b26145"
  instance_type = "t3.micro"
  key_name      = "key"
    tags = {
        purpose = "webserver"
    }
    count = 2 
}