# Amazon EKS Cluster - Terraform Configuration

This repository contains Terraform configuration for creating an Amazon Elastic Kubernetes Service (EKS) cluster in AWS.

## Overview

The Terraform configuration in this repository allows you to create an EKS cluster with customizable settings, including IAM roles and VPC configuration. This setup is ideal for running and managing Kubernetes applications on AWS.

## Prerequisites

Before you begin, ensure you have the following:

1. [Terraform](https://www.terraform.io/downloads.html) installed
2. AWS CLI configured with appropriate credentials
3. Sufficient AWS permissions to create EKS clusters and IAM roles
4. VPC and EKS endpoints have to be created prior/after cluster creation.


## Configuration Components

The Terraform configuration includes the following main components:

1. **AWS Provider**: Configures the AWS provider with the specified region.

2. **IAM Role for EKS**: Creates an IAM role that the EKS service can assume. This role is essential for the EKS cluster to interact with other AWS services.

3. **IAM Role Policy Attachment**: Attaches the necessary AWS managed policy (AmazonEKSClusterPolicy) to the IAM role, granting the required permissions for EKS operation.

4. **Security Groups Creation**: Creates EKS cluster secruity group and EKS Node Security groups essential for EKS cluster.

5. **EKS Cluster Resource**: Defines the EKS cluster with specified configurations, including:
   - Cluster name and Kubernetes version
   - VPC configuration (security groups, subnets, endpoint access settings)
   - IAM role association
   - Tags for resource management

6. **IAM USER**: The IAM user used for this EKS cluster creation will be the admin.

### Security Group Rules

- **cluster_inbound**: Allows worker nodes to communicate with the cluster API server.
- **cluster_outbound**: Allows the cluster API server to communicate with worker nodes.
- **nodes**: Allows nodes to communicate with each other.
- **nodes_inbound**: Allows worker kubelets and pods to receive communication from the cluster control plane.

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

## Key Variables

The configuration uses several variables to customize the EKS cluster setup:

- `region`: AWS region for the EKS cluster
- `owner`,`environment`and `project`: Tags for resource management
- `eks_cluster_name`: Name of the EKS cluster
- `eks_cluster_version`: Kubernetes version for the EKS cluster
- `endpoint_private_access` and `endpoint_public_access`: Control cluster endpoint access
- `subnet_ids`: List of subnet IDs for the EKS cluster

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/ramsaikrishnap/terraform.git
   ```

2. Navigate to the repository directory:
   ```
   cd terraform/aws/ec2/singleinstance
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
1. EKS cluster name
2. EKS cluster endpoint
3. OIDC URL for the cluster
4. EKS Node Security Group
5. EKS Cluster Security Group

## Important Notes

- Please note that this will create only EKS cluster and code for EKS nodes will be added soon.
- Ensure you have the necessary permissions in AWS to create EKS clusters and IAM roles.
- The EKS cluster creation process can take several minutes to complete.
- By default only endpoint private access for the EKS cluster is enabled.
- Properly configure your VPC, subnets, and security groups before creating the EKS cluster.
- After cluster creation, remember to manage your Kubernetes configuration (`kubeconfig`) to interact with the cluster.

## Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements or have found any bugs.

