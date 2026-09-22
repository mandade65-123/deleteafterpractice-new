provider "aws" {
  region = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}


resource "aws_instance"  "webserver" {
     ami = "ami-066c4849e6b3a1e3d"
     instance_type = "t3.micro" 
     vpc_security_group_ids = ["sg-09352767190d70e24",aws_security_group.webserver_sg.id]
     key_name = "key"
     tags ={
        purpose = "webserver"
     }
     count= 1
      user_data = <<-EOF
                 #!/bin/bash
                 sudo yum install nginx -y
                 sudo systemctl start nginx
                EOF

}
resource "aws_security_group" "webserver_sg" {
    name = "tf-sg-new"
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
