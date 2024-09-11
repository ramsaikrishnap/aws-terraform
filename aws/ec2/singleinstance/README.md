# EC2 Instance with Additional EBS Volume - Terraform Configuration

This repository contains Terraform configuration for creating an EC2 instance with an additional EBS volume in AWS.

## Overview

The Terraform configuration in this repository allows you to create an EC2 instance with customizable settings, including an additional EBS volume. This setup is ideal for scenarios where you need extra storage capacity beyond the root volume.

## Prerequisites

Before you begin, ensure you have the following:

1. [Terraform](https://www.terraform.io/downloads.html) installed
2. AWS CLI configured with appropriate credentials
3. AWS Access Key and Secret Key

## Configuration

The main configuration is stored in a Terraform variable file (e.g., `terraform.tfvars`). Key components include:

```hcl
region = "us-east-1"                # you can mention your required region
secret_key = "your_secret_key"      # you pass your secret key or set it as environment variable
access_key = "your_access_key"      # you pass your access key or set it as environment variable
hostname = "my-ec2-instance"        
ami = "your_ami_id"                 
instance_type = "t3.micro"          
vpc_id = "vpc-abcd1234"             
subnet_id = "subnet-ijkl6789"
key_name = "my-ssh-key"             
root_volume_size = 50
root_volume_type = "gp3"
is_root_volume_encrypted  = true
kms_key_id = "my-ebs-kms-key-id"
device_name = "/dev/sdb"
is_ebs_volume_encrypted = true
ebs_volume_size = 30
ebs_volume_type = "gp3"
```

### Using Environment Variables

For enhanced security, it's recommended to use environment variables for sensitive information like AWS credentials. Here's how:

1. Set the environment variables in your shell:
   ```
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   ```

2. Comment out the corresponding variables in your `terraform.tfvars` file:
   ```hcl
   # secret_key = "your_secret_key"
   # access_key = "your_access_key"
   ```
### Using HashiCorp Vault for Credentials

For enhanced security, you can use HashiCorp Vault to manage your AWS credentials. Here's how to set it up:

1. Ensure you have HashiCorp Vault installed and configured.

2. Store your AWS credentials in Vault:
   ```
   vault kv put secret/aws access_key=your-access-key secret_key=your-secret-key
   ```

3. In your Terraform configuration, use the Vault provider to retrieve the credentials:

   Add the following to your `main.tf`:

   ```hcl
   provider "vault" {}

   data "vault_generic_secret" "aws_credentials" {
     path = "secret/aws"
   }

   provider "aws" {
     region     = var.region
     access_key = data.vault_generic_secret.aws_credentials.data["access_key"]
     secret_key = data.vault_generic_secret.aws_credentials.data["secret_key"]
   }
   ```

4. Make sure to remove or comment out any hardcoded credentials in your Terraform files.

5. Set the `VAULT_ADDR` and `VAULT_TOKEN` environment variables:
   ```
   export VAULT_ADDR="http://your-vault-address:8200"
   export VAULT_TOKEN="your-vault-token"
   ```

By using Vault, you keep your credentials secure and centrally managed, reducing the risk of exposure.

## Instance Configuration

The configuration includes:

- EC2 instance with customizable settings
- Root volume configuration
- Additional EBS volume configuration

Key features:
- Customizable instance type (default: t3.micro)
- Configurable root volume size and type
- Option for encrypted root and EBS volumes
- Additional EBS volume with customizable size and type

## Usage

1. Clone this repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the repository directory:
   ```
   cd <repository-directory>
   ```

3. Modify the `terraform.tfvars` file with your specific configuration.

4. Initialize Terraform:
   ```
   terraform init
   ```

5. Review the planned changes:
   ```
   terraform plan
   ```

6. Apply the configuration:
   ```
   terraform apply
   ```

## Important Notes

- Ensure you replace placeholder values (e.g., "your_ami_id", "vpc-abcd1234") with your actual AWS resource IDs.
- The `secret_key` and `access_key` should be set as environment variables rather than in the Terraform files for security reasons.
- Review and adjust the instance type, volume sizes, and other parameters as per your requirements.
- The additional EBS volume is set to be attached at "/dev/sdb". Adjust if necessary.
- Both root and additional EBS volumes are set to be encrypted by default.

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or have found any bugs.

