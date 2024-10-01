terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "latest"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = "your_access_key" # This can be passed as an environment variable using command : export AWS_ACCESS_KEY_ID="anaccesskey"
  secret_key = "your_secret_key" # This can passed an environment variable using command : export AWS_SECRET_ACCESS_KEY="asecretkey"  
}