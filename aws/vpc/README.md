# AWS VPC and Subnet Terraform Configuration

This Terraform configuration sets up a Virtual Private Cloud (VPC) in AWS with customizable public and private subnets. It provides a flexible foundation for deploying AWS resources in a network-isolated environment.

## Features

- Creates a VPC with customizable CIDR block
- Sets up public and private subnets across multiple Availability Zones
- Configures Internet Gateway for public internet access
- Optional NAT Gateway for private subnet internet access
- Flexible configuration through variables

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v0.12+)
- AWS CLI configured with appropriate credentials

## File Structure

- `main.tf`: Main configuration file containing resource definitions
- `variables.tf`: Variable declarations
- `outputs.tf`: Output value definitions
- `provider.tf`: Provider configuration
- `terraform.tfvars`: Variable value assignments (create this file based on the provided sample)

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

1. Clone this repository or copy the configuration files to your local machine.

2. Create a `terraform.tfvars` file in the same directory and set the variable values according to your requirements. Use the provided sample as a reference.

3. Initialize the Terraform working directory:
   ```
   terraform init
   ```

4. Review the planned changes:
   ```
   terraform plan
   ```

5. Apply the configuration:
   ```
   terraform apply
   ```

## Customization

You can customize the VPC and subnet configuration by modifying the `terraform.tfvars` file. Here are some common scenarios:

### VPC with Only Public Subnets

```hcl
private_subnet_cidrs = []
create_nat_gateway   = false
```

### VPC with Only Private Subnets

```hcl
public_subnet_cidrs = []
create_nat_gateway  = false
```

### VPC with Public and Private Subnets (No NAT Gateway)

```hcl
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
create_nat_gateway   = false
```

### Full Setup (Public Subnets, Private Subnets, NAT Gateway)

```hcl
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
create_nat_gateway   = true
```

## Outputs

After applying the configuration, Terraform will output the following values:

- `vpc_id`: ID of the created VPC
- `public_subnet_ids`: List of IDs for the created public subnets
- `private_subnet_ids`: List of IDs for the created private subnets
- `nat_gateway_ip`: Public IP of the NAT Gateway (if created)

## Note

Remember to adjust the CIDR blocks, availability zones, and other parameters in `terraform.tfvars` to match your specific requirements and AWS account setup.

## References
1. [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
2. [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
3. [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)
4. [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)
5. [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)
6. [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
7. [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)


## Contributing

Feel free to submit issues or pull requests if you find any problems or have suggestions for improvements.
