provider "aws" {
   region = "us-east-1"
   access_key = "my-access-key"
   secret_key = "my-secret-key"   

}

resource "aws_instance" "webserver" {
    ami = "ami-0332d564d76dbd8d6"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-0eae0d103615165a6"]
    key_name = "key"
    tags ={
        purpose = "webserver"
    }
    count = 1
    }