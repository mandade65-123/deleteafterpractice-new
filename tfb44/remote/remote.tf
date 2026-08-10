provider "aws" {
  region = "ap-south-1"
  profile = "configs"
} 

#Partitionkey = LockID
terraform {
    backend "s3" {
        bucket = "cbb44"
        key = "terraform.tfstate"
        dynamodb_table = "cb-b44"
        region = "ap-south-1"
        profile = "configs"
        shared_credentials_files = ["/home/nayan123/.aws/credentials"]
    }
}



resource "aws_instance"  "webserver" {
    ami = var.amiid
    instance_type = var.insttype
    vpc_security_group_ids =  [ var.sg]
    key_name = var.kp
}