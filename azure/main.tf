// Shared resources

resource "random_string" "this" {
  length  = 12
  special = false
  upper   = false
}

resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "rg-${var.name}-${random_string.this.result}"
}

data "azurerm_client_config" "current" {}


// Variables

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "name" {
  type    = string
  default = "pcs"
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
