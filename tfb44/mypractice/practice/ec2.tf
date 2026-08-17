provider "aws" {
  region = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}


resource "aws_instance" "webserver" {
    ami = "ami-0bdc7d025135d7b49"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-0eae0d103615165a6",aws_security_group.webserver_sg.id]
    key_name = "key"
    tags = {
        purpose = "webserver"
    }
    count =2
}
resource "aws_security_group" "webserver_sg" {
name = "tf-sg"
    ingress {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks  = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks  = ["0.0.0.0/0"]
    }


    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks  = ["0.0.0.0/0"]

     }
}