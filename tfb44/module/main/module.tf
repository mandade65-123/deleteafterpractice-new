

module "ec2" {
    source = "/root/deleteafterpractice-new/tfb44/module/resource/ec2"
    amiid =  "ami-066c4849e6b3a1e3d"
    insttype = "t3.micro"
    sg = "sg-068b3ec527f853220"
    kp = "key"
    apiterm = false
   ws_subnet = module.vpc.subnet_id
}

module "vpc" {
    source = "/root/deleteafterpractice-new/tfb44/module/resource/vpc"
    this_cidr = "10.0.0.0/16"
    this_subcidr = "10.0.0.0/24"
}
