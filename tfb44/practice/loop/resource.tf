provider "aws" {
   region = "us-east-1"
   profile = "configs"
}

resource "aws_instance" "webserver" {
    ami = var.amiid
    instance_type = var.insttype
    vpc_security_group_ids = [var.sg  ]
    key_name = var.kp
    count =2
}
resource "aws_instance" "webserver" {
    for_each = toset(var.imageid)
    ami = each.value
    instance_type = var.insttype
    vpc_security_group_ids = [var.sg  ]
    key_name = var.kp
    count = 3
}


variable "imageid"  {
   default = ["ami-0332d564d76dbd8d6" , "ami-0b6d9d3d33ba97d99" , "ami-05b8af58f7410b671"]
}

output "ip" {
    value = aws_instance.webservertwo.public_ip
      
}
