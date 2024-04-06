output "resource_group_name" {
  description = "The name of the resource group for the AKS clusters"
  value       = azurerm_resource_group.aks.name
}

output "test_cluster_name" {
  description = "The name of the test AKS cluster"
  value       = azurerm_kubernetes_cluster.test.name
}

output "prod_cluster_name" {
  description = "The name of the production AKS cluster"
  value       = azurerm_kubernetes_cluster.prod.name
}

output "test_cluster_config" {
  description = "The Kubernetes configuration for the test AKS cluster"
  value = {
    host                   = azurerm_kubernetes_cluster.test.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.test.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.test.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.test.kube_config.0.cluster_ca_certificate)
  }
}

output "prod_cluster_config" {
  description = "The Kubernetes configuration for the production AKS cluster"
  value = {
    host                   = azurerm_kubernetes_cluster.prod.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.prod.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.prod.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.prod.kube_config.0.cluster_ca_certificate)
  }
}