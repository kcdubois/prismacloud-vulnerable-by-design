// Postgres

resource "azurerm_postgresql_server" "example" {
  name                = "psql${random_string.this.result}"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  sku_name = "GP_Gen5_2"

  storage_mb                    = 5120
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  auto_grow_enabled             = true
  public_network_access_enabled = true


  administrator_login               = "psqladmin"
  administrator_login_password      = "H@Sh1CoR3!"
  version                           = "11"
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
  infrastructure_encryption_enabled = false

}

resource "azurerm_postgresql_configuration" "config1" {
  name                = "log_connections"
  resource_group_name = data.azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
  value               = "off"
}

resource "azurerm_postgresql_configuration" "config2" {
  name                = "log_disconnections"
  resource_group_name = data.azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
  value               = "off"
}

resource "azurerm_postgresql_configuration" "config3" {
  name                = "connection_throttling"
  resource_group_name = data.azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
  value               = "off"
}

resource "azurerm_postgresql_database" "example" {
  name                = "exampledb"
  resource_group_name = data.azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

}

resource "azurerm_postgresql_virtual_network_rule" "example" {
  name                                 = "postgresql-vnet-rule"
  resource_group_name                  = data.azurerm_resource_group.example.name
  server_name                          = azurerm_postgresql_server.example.name
  subnet_id                            = azurerm_subnet.database.id
  ignore_missing_vnet_service_endpoint = true
}



// MSSQL server

resource "azurerm_mssql_managed_instance" "example" {
  name                = "mssql${random_string.this.result}"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location

  license_type                 = "BasePrice"
  sku_name                     = "GP_Gen5"
  storage_size_in_gb           = 32
  subnet_id                    = azurerm_subnet.database.id
  vcores                       = 4
  public_data_endpoint_enabled = true

  administrator_login          = "missadministrator"
  administrator_login_password = "NCC-1701-D"
}

resource "azurerm_mssql_managed_instance_security_alert_policy" "example" {
  resource_group_name        = data.azurerm_resource_group.example.name
  managed_instance_name      = azurerm_mssql_managed_instance.example.name
  enabled                    = true
  storage_endpoint           = azurerm_storage_account.mssql.primary_blob_endpoint
  storage_account_access_key = azurerm_storage_account.mssql.primary_access_key
  retention_days             = 30
}

resource "azurerm_mssql_managed_instance_vulnerability_assessment" "example" {
  managed_instance_id        = azurerm_mssql_managed_instance.example.id
  storage_container_path     = "${azurerm_storage_account.mssql.primary_blob_endpoint}${azurerm_storage_container.mssql.name}/"
  storage_account_access_key = azurerm_storage_account.mssql.primary_access_key

  recurring_scans {
    enabled                   = false
    email_subscription_admins = true
    emails = [
      "email@example1.com",
      "email@example2.com"
    ]
  }
  depends_on = [azurerm_mssql_managed_instance_security_alert_policy.example]
}

// MYSQL Database
resource "azurerm_mysql_server" "example" {
  name                = "mysql-${var.name}${random_string.this.result}"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  administrator_login           = "mysqladminun"
  administrator_login_password  = "H@Sh1CoR3!"
  ssl_enforcement_enabled       = true
  public_network_access_enabled = true

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

}

resource "azurerm_mysql_active_directory_administrator" "example" {
  server_name         = azurerm_mysql_server.example.name
  resource_group_name = data.azurerm_resource_group.example.name
  login               = "sqladmin"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
}
