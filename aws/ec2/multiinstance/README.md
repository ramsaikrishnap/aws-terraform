# Terraform EC2 Instance Configuration

This repository contains Terraform configuration for creating multiple EC2 instances with different configurations in AWS.

## Overview

The Terraform configuration in this repository allows you to create various EC2 instances with different operating systems (Linux and Windows) and storage configurations (with or without additional EBS volumes).

## Prerequisites

Before you begin, ensure you have the following:

1. [Terraform](https://www.terraform.io/downloads.html) installed
2. AWS CLI configured with appropriate credentials
3. AWS Access Key and Secret Key
4. (Optional) HashiCorp Vault setup for secure credential management

## Configuration

The main configuration is stored in a Terraform file (e.g., `main.tf`). Key components include:

- AWS region: `us-east-1` (configurable)
- Access and secret keys (should be set as environment variables or retrieved from HashiCorp Vault for security)
- Multiple instance configurations for both Linux and Windows

### Using Environment Variables

If you want to use environment variables for sensitive information like AWS credentials, follow these steps:

1. Set the environment variables in your shell:
   ```
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   ```

2. Comment out the corresponding variable declarations in all Terraform-related files (`variables.tf`, `main.tf`, `terraform.tfvars`). For example:

   In `variables.tf`:
   ```hcl
   # variable "access_key" {}
   # variable "secret_key" {}
   ```

   In `main.tf`:
   ```hcl
   # access_key = var.access_key
   # secret_key = var.secret_key
   ```

   In `terraform.tfvars`:
   ```hcl
   # access_key = "your-access-key"
   # secret_key = "your-secret-key"
   ```

By commenting out these variables, Terraform will automatically use the environment variables you've set.

### Using HashiCorp Vault for Credentials

For enhanced security, you can use HashiCorp Vault to manage your AWS credentials. Here's how to set it up:

1. Ensure you have HashiCorp [Vault](https://developer.hashicorp.com/vault/downloads) installed and configured.

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

## Instance Configurations

The configuration includes four different EC2 instance setups and it is stored in a Terraform variable file (e.g., `terraform.tfvars`):

1. Linux instance with additional EBS volume
2. Linux instance without additional EBS volume
3. Windows instance with additional EBS volume
4. Windows instance without additional EBS volume

Each instance configuration includes:

- Instance name
- AMI ID
- Instance type
- Subnet ID
- Security group
- SSH key pair
- Root volume configuration
- Additional EBS volume configuration (where applicable)
- Tags

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/ramsaikrishnap/terraform.git
   ```

2. Navigate to the repository directory:
   ```
   cd terraform/aws/ec2/multiinstance
   ```

3. If using Vault, ensure your Vault server is running and you've set the necessary environment variables.

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

- Ensure you replace placeholder values (e.g., "your-subnet-id", "your-security-group") with your actual AWS resource IDs.
- If not using environment variables or Vault, the `access_key` and `secret_key` can be set as environment variables rather than in the Terraform files for security reasons and best practice is to use hashicorp vault.
- When using Vault, ensure your Vault server is properly secured and that you're following Vault's security best practices.
- Review and adjust the instance types, volumes sizes, and other parameters as per your requirements.
- The EBS device name is set to "/dev/sba" by default. Adjust if necessary.
- All EBS volumes are set to be encrypted by default.

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or have found any bugs.

