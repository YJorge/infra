terraform {
  required_version = ">= 0.15.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}