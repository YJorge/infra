terraform {
     required_version = ">= 0.15.3"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.11.0"
    }   
  }
}

provider "docker" {
  host = var.host
  
  
}