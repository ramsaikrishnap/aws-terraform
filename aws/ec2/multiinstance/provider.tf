terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "latest"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}