// Shared resources

resource "random_string" "this" {
  length  = 12
  special = false
  upper   = false
}

data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}


// Variables

variable "name" {
  type    = string
  default = "pcs"
}

variable "resource_group_name" {
  type    = string
  default = "prismacloud_test_rg"
}


terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.56.0"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
}
