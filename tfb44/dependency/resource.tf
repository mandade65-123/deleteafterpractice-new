provider "aws" {
  region  = "ap-south-1"
  profile = "configs"
} 

# 1. This resource is defined first and builds first
resource "aws_security_group" "webserver_sg" {
  name = "tf-sg2"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. This builds second, explicitly waiting on the security group
resource "aws_instance" "webserver" {
  depends_on             = [aws_security_group.webserver_sg] # Your dependency block used here
  ami                    = var.amiid
  instance_type          = var.insttype
  vpc_security_group_ids = [var.sg, aws_security_group.webserver_sg.id]
  key_name               = var.kp
  count                  = 2 # identical loops
}

# 3. This runs independently in parallel or after
resource "aws_instance" "webservertwo" {
  for_each               = toset(var.imageid) # unidentical loops
  ami                    = each.value
  instance_type          = var.insttype
  vpc_security_group_ids = [var.sg]
  key_name               = var.kp
}

variable "imageid" {
  default = ["ami-0d15e9052c94acb75", "ami-01a00762f46d584a1", "ami-0b0d9b0f4dc6d00ca"]
}

output "ip" {
  value = [
    for amiid in var.imageid :  
    aws_instance.webservertwo[amiid].public_ip
  ]
}
