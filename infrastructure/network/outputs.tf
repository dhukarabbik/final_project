output "resource_group_name" {
  description = "The name of the resource group for the network"
  value       = azurerm_resource_group.network.name
}

output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_names" {
  description = "The names of the subnets"
  value = [
    azurerm_subnet.prod.name,
    azurerm_subnet.test.name,
    azurerm_subnet.dev.name,
    azurerm_subnet.admin.name
  ]
}