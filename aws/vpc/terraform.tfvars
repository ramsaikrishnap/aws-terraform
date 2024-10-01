
vpc_cidr             = "10.0.0.0/16"
vpc_name             = "my-vpc"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["us-west-2a", "us-west-2b"]
create_nat_gateway   = true
aws_region           = "us-west-2"