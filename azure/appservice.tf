resource "azurerm_service_plan" "example" {
  name                = "plan-${random_string.this.result}"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "example" {
  name                = "appsrv-${random_string.this.result}"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id
  https_only          = false

  auth_settings {
    enabled = false
  }
  site_config {
    worker_count = 1
  }
}


resource "azurerm_linux_function_app" "example" {
  name                = "funcapp-${random_string.this.result}"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location

  storage_account_name       = azurerm_storage_account.func.name
  storage_account_access_key = azurerm_storage_account.func.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  auth_settings {
    enabled = false
  }

  site_config {}
}
