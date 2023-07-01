terraform {
  required_version = ">= 0.15.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38"
    }

    ct = {
      source  = "poseidon/ct"
      version = "0.8.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

provider "ct" {}

locals {
  # FEDORA-COREOS
  instance_ami      = "ami-09e2e5104f310ffb5"
  instance_user     = "core"
  instance_key_file = "ssh_keys/id_rsa_instance_key.pub"
}

resource "aws_instance" "app_server" {
  ami           = local.instance_ami
  instance_type = "t2.micro"
  user_data     = data.ct_config.config.rendered

  tags = {
    Name = "Study AppServer"
  }

  vpc_security_group_ids = [
    module.ec2_sg.security_group_id
  ]
}

data "aws_vpc" "default" {
  default = true
}

data "ct_config" "config" {
  content = templatefile("config.tpl", {
    user = local.instance_user
    key  = file(local.instance_key_file)
  })
  strict = true
}

module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2_sg"
  description = "Security group for ec2_sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}
