resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  dns_prefix = "prismacloud"
  name       = "prismacloud-ca-central-aks"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2_v2"
    node_count          = 1
    vnet_subnet_id      = azurerm_subnet.public.id
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
  }
}
