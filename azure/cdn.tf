resource "azurerm_cdn_frontdoor_profile" "example" {
  name                = "cdn${random_string.this.result}"
  resource_group_name = data.azurerm_resource_group.example.name
  sku_name            = "Standard_AzureFrontDoor"
}


resource "azurerm_cdn_frontdoor_endpoint" "example" {
  name                     = "cdn-endpoint-${random_string.this.result}"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.example.id
}


// Application gateway

resource "azurerm_public_ip" "appgw" {
  name                = "appgw-${random_string.this.result}-pip"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  allocation_method   = "Dynamic"
}

resource "azurerm_application_gateway" "example" {
  name                = "appgw-${random_string.this.result}"
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gw-ip-configuration"
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = "${azurerm_virtual_network.example.name}-feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${azurerm_virtual_network.example.name}-feip"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  backend_address_pool {
    name = "${azurerm_virtual_network.example.name}-beap"
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.example.name}-be-htst"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${azurerm_virtual_network.example.name}-httplstn"
    frontend_ip_configuration_name = "${azurerm_virtual_network.example.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.example.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${azurerm_virtual_network.example.name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.example.name}-httplstn"
    backend_address_pool_name  = "${azurerm_virtual_network.example.name}-beap"
    backend_http_settings_name = "${azurerm_virtual_network.example.name}-be-htst"
  }
}
