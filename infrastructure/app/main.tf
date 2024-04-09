resource "azurerm_resource_group" "weather_app" {
  name     = "rg-weather-app-${var.environment}"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "acrweatherapp${var.environment}"
  resource_group_name = azurerm_resource_group.weather_app.name
  location            = azurerm_resource_group.weather_app.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-weather-app-${var.environment}"
  location            = azurerm_resource_group.weather_app.location
  resource_group_name = azurerm_resource_group.weather_app.name
  dns_prefix          = "aks-weather-app-${var.environment}"

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.21.2"
}

resource "azurerm_redis_cache" "redis" {
  name                = "redis-weather-app-${var.environment}"
  location            = azurerm_resource_group.weather_app.location
  resource_group_name = azurerm_resource_group.weather_app.name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
}

# Kubernetes resources
resource "kubernetes_deployment" "weather_app" {
  metadata {
    name = "weather-app"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "weather-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "weather-app"
        }
      }

      spec {
        container {
          name  = "weather-app"
          image = "${azurerm_container_registry.acr.login_server}/weather-app:${var.image_tag}"

          env {
            name  = "REDIS_HOST"
            value = azurerm_redis_cache.redis.hostname
          }

          env {
            name  = "REDIS_PORT"
            value = "6379"
          }

        #   ports {
        #     container_port = 80
        #     container_port = 443
        #   }
        }
      }
    }
  }
}

resource "kubernetes_service" "weather_app" {
  metadata {
    name = "weather-app"
  }

  spec {
    selector = {
      app = "weather-app"
    }

    port {
      port        = 80
      target_port = 80
    }

    port {
      port        = 443
      target_port = 443
    }

    type = "LoadBalancer"
  }
}