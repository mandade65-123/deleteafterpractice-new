provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket       = "cbb44"
    key          = "terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true # Modern native S3 locking method
  }
}

resource "aws_instance" "webserver" {
  ami                    = var.amiid
  instance_type          = var.insttype
  vpc_security_group_ids = [var.sg]
  key_name               = var.kp
}
