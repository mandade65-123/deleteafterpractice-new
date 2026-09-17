

module "ec2" {
    source = "/root/deleteafterpractice-new/tfb44/revision/module/resource/ec2"
    amiid = "ami-0e34b50e714a297f1"
    insttype = "t3.micro"
    sg = "sg-00af24a514ce5e504"
    kp = "newkey"
    instno = 1
    apiterm = false
    ws_subnet = module.vpc.subnet_id
}

module "vpc" {

    source = "/root/deleteafterpractice-new/tfb44/revision/module/resource/vpc"
    this_cidr = "10.0.0.0/16"
    this_subcidr = "10.0.0.0/24"
    
}