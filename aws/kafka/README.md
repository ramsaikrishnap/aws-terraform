# Kafka Cluster - Terraform Configuration

This repository contains Terraform configuration for creating a kafka cluster in AWS.

## Overview

The Terraform configuration in this repository allows you to create a kafka cluster with configuration.

## Prerequisites

Before you begin, ensure you have the following:

1. [Terraform](https://www.terraform.io/downloads.html) installed
2. AWS CLI configured with appropriate credentials
3. AWS Access Key and Secret Key

## Configuration
1. **MSK Cluster**: It creates MSK cluster with customizable properties like number of broker,broker node group information including instance type,client subnets,configuration information,security groups,storage information and also tags.
2 **MSK configration**: It also creates msk configration setup with required server properties.Please note that you can add your required server properties additional other than properties given in the code.

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

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/ramsaikrishnap/terraform.git
   ```

2. Navigate to the repository directory:
   ```
   cd terraform/aws/kafka
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

## Outputs
1. MSK cluster ARN
2. MSK cluster Configuration ARN

## References
1. [aws_msk_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/msk_cluster)
2. [aws_msk_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_configuration)

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or have found any bugs.

