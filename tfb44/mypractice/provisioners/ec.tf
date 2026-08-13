provider "aws" {
  region  = "us-east-1"
  profile = "configs"
}

resource "aws_instance" "webserver" {
  ami                    = var.amiid
  instance_type          = var.insttype
  vpc_security_group_ids = [var.sg]
  key_name               = var.kp

  # Connection block placed here applies to all remote provisioners
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/tf.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "sample.txt"
    destination = "/home/ec2-user/aws/sample.txt" 
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}
