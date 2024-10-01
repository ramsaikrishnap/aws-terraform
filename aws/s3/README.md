# AWS S3 Bucket Terraform Configuration

This Terraform configuration sets up an Amazon S3 bucket with customizable settings for versioning, encryption, and public access controls.

## Features

- Creates an S3 bucket with a custom name
- Configures bucket ownership controls
- Sets up public access blocking
- Optional versioning
- Enables server-side encryption by default
- Allows for custom tagging

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

6. When you're done, you can destroy the created resources:
   ```
   terraform destroy
   ```

## Customization

You can customize the S3 bucket configuration by modifying the `terraform.tfvars` file. Here are some common scenarios:

### Basic S3 Bucket

```hcl
bucket_name = "my-unique-bucket-name"
aws_region  = "us-west-2"
```

### S3 Bucket with Versioning Enabled

```hcl
bucket_name       = "my-versioned-bucket"
aws_region        = "us-west-2"
enable_versioning = true
```

### S3 Bucket with Custom Tags

```hcl
bucket_name = "my-tagged-bucket"
aws_region  = "us-west-2"
tags = {
  Environment = "Production"
  Project     = "MyApp"
}
```

### S3 Bucket with Public Access Allowed

```hcl
bucket_name             = "my-public-bucket"
aws_region              = "us-west-2"
block_public_acls       = false
block_public_policy     = false
ignore_public_acls      = false
restrict_public_buckets = false
```

## Outputs

After applying the configuration, Terraform will output the following values:

- `bucket_id`: The name of the created S3 bucket
- `bucket_arn`: The ARN (Amazon Resource Name) of the bucket
- `bucket_domain_name`: The domain name of the bucket

## References
1. [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
2. [aws_s3_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls)
3. [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/-/aws/latest/docs/resources/s3_bucket_public_access_block)
4. [aws_s3_bucket_versioning](https://registry.terraform.io/providers/-/aws/latest/docs/resources/s3_bucket_versioning)
5. [aws_s3_bucket_server_side_encryption_configuration](https://registry.terraform.io/providers/-/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration)


## Security Considerations

By default, this configuration sets up the S3 bucket with strict security settings:

- Public access is blocked
- Server-side encryption is enabled using AES256
- Bucket ownership controls are set to "BucketOwnerPreferred"

Modify these settings only if you have specific requirements and understand the security implications.

## Note

Remember to choose a globally unique name for your S3 bucket. AWS requires that bucket names be globally unique across all AWS accounts.

## Contributing

Feel free to submit issues or pull requests if you find any problems or have suggestions for improvements.
