provider "aws" {
  region  = "us-east-1"
  profile = "configs"
}

resource "aws_instance" "webserver" {
  ami                    = var.amiid
  instance_type          = var.insttype
  vpc_security_group_ids = [var.sg]
  key_name               = var.key # Ensure this variable matches your .tfvars

  # STEP 1: Define connection first. Terraform loads tf.pem into memory here.
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/tf.pem")
    host        = self.public_ip
    timeout     = "5m" # Gives AWS enough time to boot up the SSH service
  }

  # STEP 2: Create the target directory so the file transfer doesn't crash
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ec2-user/aws/"
    ]
  }

  # STEP 3: Transfer the file safely using the connection loaded in Step 1
  provisioner "file" {
    source      = "sample.txt"
    destination = "/home/ec2-user/aws/sample.txt"
  }

  # STEP 4: Run local script logging
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }

  # STEP 5: Install and configure Apache
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}
