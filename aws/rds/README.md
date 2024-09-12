# Terraform RDS Configuration with Read Replica

This Terraform configuration sets up an Amazon RDS (Relational Database Service) instance along with its associated resources, including a read replica.

## Prerequisites

Before you begin, ensure you have the following:

1. [Terraform](https://www.terraform.io/downloads.html) installed
2. AWS CLI configured with appropriate credentials
3. AWS Access Key and Secret Key

## Resources Created

1. `aws_db_subnet_group`: Creates a DB subnet group for the RDS instance.
2. `aws_db_option_group`: Sets up an option group for the RDS instance.
3. `aws_db_parameter_group`: Creates a parameter group for the RDS instance.
4. `aws_db_instance` (primary): The main RDS instance resource.
5. `aws_db_instance` (replica): A read replica of the main RDS instance.

## Variables

This configuration uses several variables to customize the RDS instances. Some key variables include:

- `db_instance_name`: Name of the primary DB instance
- `db_engine`: The database engine (e.g., MySQL, PostgreSQL)
- `db_engine_version`: Version of the database engine
- `db_instance_class`: The instance type for the primary RDS instance
- `replica_instance_class`: The instance type for the read replica
- `db_allocated_storage`: Amount of storage allocated to the DB instance
- `username` and `password`: Credentials for the database
- `db_multi_az`: Whether to enable Multi-AZ deployment

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
6. Store your RDS username and password in Vault:
   ```
   vault kv put secret/rdsuserinfo username=your-database-username password=your-database-password
   ```

7. For accessing the username and password in the terraform configuration from vault
   ```hcl
   provider "vault" {}

   data "vault_generic_secret" "rds_database_credentials" {
     path = "secret/rdsuserinfo"
   }

   resource "aws_db_instance" "db" {
     username = data.vault_generic_secret.rds_database_credentials.data["username"]
     password = data.vault_generic_secret.rds_database_credentials.data["password"]
   }
   ```


By using Vault, you keep your credentials secure and centrally managed, reducing the risk of exposure.


## Usage

To use this configuration:

1. Ensure you have Terraform installed.
2. Set the required variables in a `terraform.tfvars` file or via command line flags.
3. Run `terraform init` to initialize the Terraform working directory.
4. Run `terraform plan` to see the execution plan.
5. Run `terraform apply` to create the resources.

## Primary RDS Instance

The primary RDS instance is created with the following key configurations:

- Storage encryption is enabled by default (`storage_encrypted = true`).
- Auto minor version upgrades are enabled (`auto_minor_version_upgrade = true`).
- `skip_final_snapshot` is set to `true`. In a production environment, you might want to set this to `false` and specify a `final_snapshot_identifier`.

## Read Replica

A read replica of the primary RDS instance is created with the following characteristics:

- The replica.tf file should be removed/deleted when you do not require any read replica for your RDS Instance and also output for rds read replica endpoint should also be commented in output.tf file.
- It replicates from the primary instance (`replicate_source_db = aws_db_instance.db.identifier`).
- The identifier is based on the primary instance's name with "-readreplica" appended.
- It inherits many settings from the primary instance, including engine, version, security groups, and parameter group.
- The instance class can be different from the primary instance, specified by `var.replica_instance_class`.

## Important Notes

- The read replica depends on the primary instance and will be created after the primary instance is available.
- Both the primary instance and the read replica have `skip_final_snapshot = true`. Adjust this for production use.
- Ensure your AWS account limits can accommodate both the primary and replica instances.

## Customization

You can customize this configuration by modifying the variables or adding additional resources as needed for your specific use case. Consider adjusting the replica's configuration if you need different settings from the primary instance.

## Outputs
1. RDS Primary Instance Endpoint
2. RDS Read Replica Instance Endpoint 

## References
1. [aws_db_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)
2. [aws_db_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group)
3. [aws_db_option_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group)
4. [aws_db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)
5. [aws_rds_engine_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/rds_engine_version)
## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or have found any bugs.