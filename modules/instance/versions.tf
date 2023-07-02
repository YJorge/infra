terraform {
  required_version = ">= 0.15.3"

  required_providers {
  ct = {
      source  = "poseidon/ct"
      version = "0.8.0"
    }
  }
}
