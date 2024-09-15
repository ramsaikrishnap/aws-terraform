# Terraform Project

## What is Terraform?

Terraform is an open-source Infrastructure as Code (IaC) tool created by HashiCorp. It allows you to define and provision infrastructure resources using a declarative configuration language. With Terraform, you can manage a wide variety of service providers as well as custom in-house solutions.

## Uses of Terraform

1. **Multi-Cloud Deployment**: Manage resources across multiple cloud providers.
2. **Application Infrastructure**: Define and manage the infrastructure required for your applications.
3. **Self-Service Clusters**: Create reusable modules for your teams to create infrastructure on-demand.
4. **Policy Compliance**: Enforce organizational standards across all infrastructure.
5. **Software Defined Networking**: Manage network infrastructure for both cloud and on-premises.

## Installation

To install Terraform, follow these steps:

1. Visit the [official Terraform downloads page](https://www.terraform.io/downloads.html).
2. Download the package for your operating system.
3. Extract the downloaded zip file.
4. Move the `terraform` binary to a directory included in your system's PATH.

For macOS and Linux users, you can use package managers:

- macOS (using Homebrew):
  ```
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform
  ```

- Linux (using apt):
  ```
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform
  ```

Verify the installation by running:
```
terraform version
```

## Basic Terraform Commands with Sample Outputs

Here are some essential Terraform commands along with sample outputs:

1. `terraform init`: Initialize a Terraform working directory
   ```
   $ terraform init

   Initializing the backend...

   Initializing provider plugins...
   - Finding latest version of hashicorp/aws...
   - Installing hashicorp/aws v4.67.0...
   - Installed hashicorp/aws v4.67.0 (signed by HashiCorp)

   Terraform has been successfully initialized!
   ```

2. `terraform plan`: Generate and show an execution plan
   ```
   $ terraform plan

   Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
     + create

   Terraform will perform the following actions:

     # aws_instance.example will be created
     + resource "aws_instance" "example" {
         + ami                          = "ami-0c55b159cbfafe1f0"
         + instance_type                = "t2.micro"
         + ...
       }

   Plan: 1 to add, 0 to change, 0 to destroy.
   ```

3. `terraform apply`: Builds or changes infrastructure
   ```
   $ terraform apply

   # ... (plan output) ...

   Do you want to perform these actions?
     Terraform will perform the actions described above.
     Only 'yes' will be accepted to approve.

   Enter a value: yes

   aws_instance.example: Creating...
   aws_instance.example: Creation complete after 30s [id=i-1234567890abcdef0]

   Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
   ```

4. `terraform destroy`: Destroy Terraform-managed infrastructure
   ```
   $ terraform destroy

   # ... (plan output) ...

   Do you really want to destroy all resources?
     Terraform will destroy all your managed infrastructure, as shown above.
     There is no undo. Only 'yes' will be accepted to confirm.

   Enter a value: yes

   aws_instance.example: Destroying... [id=i-1234567890abcdef0]
   aws_instance.example: Destruction complete after 1m30s

   Destroy complete! Resources: 1 destroyed.
   ```

5. `terraform validate`: Validates the Terraform files
   ```
   $ terraform validate

   Success! The configuration is valid.
   ```

6. `terraform fmt`: Rewrites config files to canonical format
   ```
   $ terraform fmt

   main.tf
   variables.tf
   ```

7. `terraform show`: Inspect Terraform state or plan
   ```
   $ terraform show

   # aws_instance.example:
   resource "aws_instance" "example" {
       ami                          = "ami-0c55b159cbfafe1f0"
       arn                          = "arn:aws:ec2:us-west-2:123456789012:instance/i-1234567890abcdef0"
       associate_public_ip_address  = true
       availability_zone            = "us-west-2a"
       ...
   }
   ```

## Terraform Workspace Commands

Terraform workspaces allow you to manage multiple states for a single configuration. Here are the workspace-related commands:

- `terraform workspace list`: List available workspaces
- `terraform workspace select [NAME]`: Select a workspace
- `terraform workspace new [NAME]`: Create a new workspace
- `terraform workspace delete [NAME]`: Delete an existing workspace
- `terraform workspace show`: Show the name of the current workspace

Example usage:
```
$ terraform workspace list
  default
  development
* production

$ terraform workspace new staging
Created and switched to workspace "staging"!

$ terraform workspace select production
Switched to workspace "production".
```

## Methods to Pass Variables to Terraform

There are several ways to pass variables to Terraform:

1. **Command Line Flags**: 
   ```
   terraform apply -var="instance_type=t2.micro" -var="instance_count=5"
   ```

2. **Variable Files**: Create a file named `terraform.tfvars` or any file with `.tfvars` extension.
   ```
   # contents of terraform.tfvars
   instance_type = "t2.micro"
   instance_count = 5
   ```
   Then run:
   ```
   terraform apply
   ```
   Or specify a different var-file:
   ```
   terraform apply -var-file="testing.tfvars"
   ```

3. **Environment Variables**: Prefix your variable name with `TF_VAR_`.
   ```
   export TF_VAR_instance_type="t2.micro"
   export TF_VAR_instance_count=5
   terraform apply
   ```

4. **Default Values**: In your `variables.tf` file, you can specify default values.
   ```hcl
   variable "instance_type" {
     default = "t2.micro"
   }
   ```

5. **Interactive Input**: If you don't provide a value for a variable, Terraform will interactively ask you to input the value.

## Terraform Plan and Apply in Detail

### Terraform Plan

`terraform plan` creates an execution plan, allowing you to preview the changes Terraform will make to your infrastructure. It's a dry run and doesn't actually change anything.

Key points:
- It checks the current state of any already-existing remote objects to make sure Terraform state is up-to-date.
- It compares the current configuration to the prior state and notes any differences.
- It proposes a set of change actions that should, if applied, make the remote objects match the configuration.

The output uses the following symbols:
- `+` for creation
- `-` for deletion
- `~` for modification

### Terraform Apply

`terraform apply` executes the actions proposed in a Terraform plan. It's used to apply the changes required to reach the desired state of the configuration.

Key points:
- By default, it creates a new execution plan (as if you had run `terraform plan`) and prompts for approval before making any changes.
- You can provide a saved plan file from a previous `terraform plan` execution.
- It updates the state file after successfully applying the changes.

Best practices:
1. Always run `terraform plan` before `terraform apply` to verify the changes.
2. Use `-out` flag with `plan` to save the plan, then use this saved plan with `apply` to ensure the exact changes you reviewed are applied.

   ```
   terraform plan -out=tfplan
   terraform apply tfplan
   ```

3. In automated workflows, you can use the `-auto-approve` flag, but be cautious as it applies changes without asking for confirmation.

   ```
   terraform apply -auto-approve
   ```

Remember to refer to the [official Terraform documentation](https://www.terraform.io/docs/index.html) for more detailed information and advanced usage.
## Best Practices

1. Use version control for your Terraform configurations
2. Implement remote state storage
3. Use modules to organize and reuse your code
4. Always run `terraform plan` before `terraform apply`
5. Use variables and outputs to make your configurations more flexible
6. Implement state locking to prevent concurrent state operations

Remember to refer to the [official Terraform documentation](https://www.terraform.io/docs/index.html) for more detailed information and advanced usage.