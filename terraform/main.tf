module "networking" {
  source = "../modules/networking"

  name               = "strapi"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  az                 = "ap-south-1a"
}

module "security_group" {
  source = "../modules/security-group"

  name   = "strapi"
  vpc_id = module.networking.vpc_id
}

module "keypair" {
  source = "../modules/keypair"

  key_name = "rushi_key"
  ssh_dir  = "C:\\Users\\Admin\\.ssh"
}

module "ami" {
  source = "../modules/ami"
}

module "ec2" {
  source = "../modules/ec2"

  name              = "strapi"
  ami_id            = module.ami.ami_id
  instance_type     = "t3.medium"
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.security_group.security_group_id
  key_name          = module.keypair.key_name
  user_data         = file("${path.module}/user_data.sh")
}
