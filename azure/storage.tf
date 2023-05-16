resource "azurerm_storage_account" "storage1" {
  name                          = "kcdubois${random_string.this.result}2"
  resource_group_name           = azurerm_resource_group.example.name
  location                      = azurerm_resource_group.example.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  public_network_access_enabled = true
  min_tls_version               = "TLS1_1"
  enable_https_traffic_only     = false

  tags = {
    environment = "staging"
  }
}