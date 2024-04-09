output "resource_group_name" {
  description = "The name of the resource group for Terraform state"
  value       = azurerm_resource_group.terraform_state.name
}

output "storage_account_name" {
  description = "The name of the storage account for Terraform state"
  value       = azurerm_storage_account.terraform_state.name
}

output "container_name" {
  description = "The name of the storage container for Terraform state"
  value       = azurerm_storage_container.terraform_state.name
}