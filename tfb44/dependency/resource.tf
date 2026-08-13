provider "aws" {
  region = "ap-south-1"
  profile = "configs"
} 


resource "aws_instance"  "webserver" {
    ami = var.amiid
    instance_type = var.insttype
    vpc_security_group_ids =  [ var.sg ]
    key_name = var.kp
    count = 2  #identicalloops
}



resource "aws_instance"  "webservertwo" {
    for_each = toset(var.imageid)    #unidenticalloops
    ami = each.value
    instance_type = var.insttype
    vpc_security_group_ids =  [ var.sg]
    key_name = var.kp

}




variable "imageid" {
   default = ["ami-0d15e9052c94acb75" , "ami-01a00762f46d584a1" , "ami-0b0d9b0f4dc6d00ca"]
}

output "ip" {
    value = [
      for amiid in var.imageid:  
        aws_instance.webservertwo[amiid].public_ip]
}
