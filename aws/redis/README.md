# AWS ElastiCache Redis Cluster Terraform Module

This Terraform module creates an AWS ElastiCache Redis cluster with associated resources.

## Resources Created

1. `aws_elasticache_replication_group`: The main Redis cluster
2. `aws_elasticache_parameter_group`: A parameter group for the Redis cluster
3. `aws_elasticache_subnet_group`: A subnet group for the Redis cluster

## Prerequisites

- Terraform installed
- AWS credentials configured
- Required variables defined (see Variables section)

## Usage

```hcl
module "redis_cluster" {
  source = "./path/to/this/module"

  redis_cluster_name    = "my-redis-cluster"
  redis_version         = "6.x"
  port                  = 6379
  num_cache_clusters    = 2
  node_type             = "cache.t3.micro"
  parameter_group_family = "redis6.x"
  subnet_ids            = ["subnet-12345678", "subnet-87654321"]
  
  # Other variables...
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `redis_cluster_name` | Name of the Redis cluster | `string` | n/a | yes |
| `redis_version` | Redis engine version | `string` | n/a | yes |
| `port` | Port number for Redis | `number` | n/a | yes |
| `num_cache_clusters` | Number of cache clusters in the replication group | `number` | n/a | yes |
| `node_type` | Instance type of the cache nodes | `string` | n/a | yes |
| `kms_key_id` | ARN of the KMS key for encryption | `string` | n/a | yes |
| `at_rest_encryption_enabled` | Enable encryption at rest | `bool` | n/a | yes |
| `auto_minor_version_upgrade` | Enable automatic minor version upgrades | `bool` | n/a | yes |
| `automatic_failover_enabled` | Enable automatic failover | `bool` | n/a | yes |
| `transit_encryption_enabled` | Enable transit encryption | `bool` | n/a | yes |
| `auth_token` | Authentication token for Redis | `string` | n/a | yes |
| `apply_immediately` | Apply changes immediately | `bool` | n/a | yes |
| `project` | Project name for tagging | `string` | n/a | yes |
| `environment` | Environment name for tagging | `string` | n/a | yes |
| `parameter_group_family` | Family of the ElastiCache parameter group | `string` | n/a | yes |
| `subnet_ids` | List of subnet IDs for the subnet group | `list(string)` | n/a | yes |

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

## Outputs

This module doesn't define any outputs. Consider adding outputs for important attributes like the cluster endpoint or configuration endpoint if needed.

## Notes

- The security group for the Redis cluster is currently empty (`security_group_ids = []`). Make sure to add appropriate security group IDs to control access to your Redis cluster.
- The `create_before_destroy` lifecycle rule is set for the parameter group. This ensures that a new parameter group is created before the old one is destroyed during updates.
- Ensure that the `subnet_ids` you provide are in the same VPC and are appropriately configured for your Redis cluster.

## References
1. [aws_elasticache_replication_group](https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/elasticache_replication_group)
2. [aws_elasticache_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group)
3. [aws_elasticache_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group)

## Contributing

Contributions to improve this module are welcome. Please submit a pull request or open an issue to discuss proposed changes.

