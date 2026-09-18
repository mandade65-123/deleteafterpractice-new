provider "aws" {
  region = "ap-south-1"
  profile = "configs"
} 


resource "aws_instance"  "webserver" {
    ami = var.amiid
    instance_type = var.insttype
    vpc_security_group_ids =  [ var.sg ]
    key_name = var.kp
    count = 1  #identicalloops
}



resource "aws_instance"  "webservertwo" {
    for_each = toset(var.imageid)    #unidenticalloops
    ami = each.value
    instance_type = var.insttype
    vpc_security_group_ids =  [ var.sg]
    key_name = var.kp

}




variable "imageid" {
   default = ["ami-01e28c444f355e81e" , "ami-04963e794c6160539 " , "ami-0bec5e13b8c879f58"]
}

output "ip" {
    value = [
      for amiid in var.imageid:  
        aws_instance.webservertwo[amiid].public_ip]
}
