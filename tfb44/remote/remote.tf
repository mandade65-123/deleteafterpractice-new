provider "aws" {
  region  = "ap-south-1"
  profile = "configs"
}

terraform {
  backend "s3" {
    bucket                  = "cbb44"
    key                     = "terraform.tfstate"
    region                  = "ap-south-1"
    profile                 = "configs"
    shared_credentials_file = "/home/nayan123/.aws/credentials"
    use_lockfile            = true # Replaces deprecated dynamodb_table
  }
}

resource "aws_instance" "webserver" {
  ami                    = var.amiid
  instance_type          = var.insttype
  vpc_security_group_ids = [var.sg]
  key_name               = var.kp
}
