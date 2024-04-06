variable "environment" {
  description = "The environment (dev, test, prod)"
  type        = string
}

variable "location" {
  description = "The Azure region to create resources in"
  type        = string
  default     = "West Europe"
}

variable "aks_node_count" {
  description = "The number of nodes in the AKS cluster"
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "The VM size for the AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "image_tag" {
  description = "The Docker image tag for the Remix Weather Application"
  type        = string
}