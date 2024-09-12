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
  access_key = "your-access-key" # This can be passed as an environment variable using command : export AWS_ACCESS_KEY_ID="anaccesskey"
  secret_key = "your-secret-key" # This can passed an environment variable using command : export AWS_SECRET_ACCESS_KEY="asecretkey"  
}