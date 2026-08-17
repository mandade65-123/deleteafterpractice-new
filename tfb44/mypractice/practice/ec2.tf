provider "aws" {
  region = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}


resource "aws_instance" "webserver" {
    ami = var.amiid
    instance_type = var.instype
    vpc_security_group_ids = [var.sg,aws_security_group.webserver_sg1.id]
    key_name = var.kp
    tags = {
        purpose = "webserver"
    }
    count = var.instno
    disable_api_termination = var.apiterm
     user_data = <<-EOF
                 #!/bin/bash
                 sudo yum install nginx -y
                 sudo systemctl start nginx
                EOF

}

resource "aws_security_group" "webserver_sg1" {
name = "tf-sg-n"
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