

module "ec2" {
    source = "/root/deleteafterpractice-new/tfb44/module/resource/ec2"
    amiid =  "ami-0bdc7d025135d7b49"
    insttype = "t3.micro"
    sg = "sg-0ee3610068198e56e"
    kp = "key"
    apiterm = false
   ws_subnet = module.vpc.subnet_id
}

module "vpc" {
    source = "/root/deleteafterpractice-new/tfb44/module/resource/vpc"
    this_cidr = "10.0.0.0/16"
    this_subcidr = "10.0.0.0/24"
}
