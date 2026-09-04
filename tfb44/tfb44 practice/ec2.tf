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

