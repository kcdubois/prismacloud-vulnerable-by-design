# Azure Vulnerable environment

To use this set of Terraform template, simply update the variables in `main.tf` 
to change the name prefix and the default location. Every resource will be 
created under a resource group named `rg-{name}-{random}`.