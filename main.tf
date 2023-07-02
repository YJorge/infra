module "application" {
  source = "./modules/application"
  host   = "ssh://${var.instance_user}@${module.instance.public_ip}:22"
  image  = var.image
}

module "instance" {
  source       = "./modules/instance"
  instance_ami = var.instance_ami
  user         = var.instance_user
  ssh_key      = var.instance_key_file
  ec2_sg_id    = module.networking.ec2_sg_id
}

module "networking" {
  source = "./modules/networking"
}