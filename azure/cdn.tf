resource "azurerm_cdn_frontdoor_profile" "example" {
  name                = "cdn${random_string.this.result}"
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Standard_AzureFrontDoor"
}


resource "azurerm_cdn_frontdoor_endpoint" "example" {
  name                     = "cdn-endpoint-${random_string.this.result}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
}
