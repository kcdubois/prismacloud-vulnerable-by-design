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
