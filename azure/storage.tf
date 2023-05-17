resource "azurerm_storage_account" "storage1" {
  name                          = "kcdubois${random_string.this.result}2"
  resource_group_name           = azurerm_resource_group.example.name
  location                      = azurerm_resource_group.example.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = true
  min_tls_version               = "TLS1_1"
  enable_https_traffic_only     = false
}


// Activity logs
resource "azurerm_storage_account" "logs" {
  name                              = "logs${random_string.this.result}2"
  resource_group_name               = azurerm_resource_group.example.name
  location                          = azurerm_resource_group.example.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  infrastructure_encryption_enabled = false
}


// MSSQL
resource "azurerm_storage_account" "mssql" {
  name                     = "acct${var.name}${random_string.this.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "mssql" {
  name                  = "container${var.name}${random_string.this.result}"
  storage_account_name  = azurerm_storage_account.mssql.name
  container_access_type = "private"
}


// Function app
resource "azurerm_storage_account" "func" {
  name                              = "funcapp${random_string.this.result}2"
  resource_group_name               = azurerm_resource_group.example.name
  location                          = azurerm_resource_group.example.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  infrastructure_encryption_enabled = false
}
