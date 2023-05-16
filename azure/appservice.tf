resource "azurerm_service_plan" "example" {
  name                = "plan-${random_string.this.result}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "example" {
  name                = "appsrv-${random_string.this.result}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id
  https_only          = false

  site_config {
    worker_count = 1
  }
}
