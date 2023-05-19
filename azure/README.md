# Azure Vulnerable environment

This Azure virtual environment deploys multiple resources to an existing 
resource group. To get started, first open `main.tf` and edit the values of 
`var.name` and `var.resource_group_name` to reflect the values of your environment.

In the Azure Cloud shell or on your local workstation with Terraform and Azure CLI:
```bash
terraform init
terraform apply -auto-approve
```