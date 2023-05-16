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
