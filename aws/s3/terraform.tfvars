# terraform.tfvars (sample)

bucket_name        = "my-unique-bucket-name"
aws_region         = "us-west-2"
enable_versioning  = true
tags = {
  Environment = "Production"
  Project     = "MyApp"
}