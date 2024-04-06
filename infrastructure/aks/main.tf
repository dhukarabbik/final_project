resource "azurerm_resource_group" "aks" {
  name     = "rg-aks-weather-app"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "test" {
  name                = "aks-weather-app-test"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "aks-weather-app-test"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.21.2"
}

resource "azurerm_kubernetes_cluster" "prod" {
  name                = "aks-weather-app-prod"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "aks-weather-app-prod"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.21.2"
}