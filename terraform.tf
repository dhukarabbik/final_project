terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstate"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  version = "~> 2.46.0"
  features {}
}

provider "kubernetes" {
  host                   = module.aks.host
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

module "backend" {
  source = "./infrastructure/backend"
}

module "network" {
  source = "./infrastructure/network"
}

module "aks" {
  source = "./infrastructure/aks"
}

module "app" {
  source = "./infrastructure/app"

  environment   = "test"
  location      = "West Europe"
  aks_node_count = 1
  aks_vm_size    = "Standard_B2s"
  image_tag      = "latest"
}

module "app_dev" {
  source = "./infrastructure/app"

  environment   = "dev"
  location      = "West Europe"
  aks_node_count = 1
  aks_vm_size    = "Standard_B2s"
  image_tag      = "latest"
}

module "app_prod" {
  source = "./infrastructure/app"

  environment   = "prod"
  location      = "West Europe"
  aks_node_count = 3
  aks_vm_size    = "Standard_B2s"
  image_tag      = "latest"
}