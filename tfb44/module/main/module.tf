

module "ec2" {
    source = "/root/deleteafterpractice-new/tfb44/module/resource/ec2"
    amiid =  "ami-035827357e3c7e810"
    insttype = "t3.micro"
    sg = "sg-06c6423a2b60b21cd"
    kp = "key"
    apiterm = false
   ws_subnet = module.vpc.subnet_id
}

module "vpc" {
    source = "/root/deleteafterpractice-new/tfb44/module/resource/vpc"
    this_cidr = "10.0.0.0/16"
    this_subcidr = "10.0.0.0/24"
}
