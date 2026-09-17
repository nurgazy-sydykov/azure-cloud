resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Basic"

  admin_enabled = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                  = "${var.acr_name}-build-task"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/nurgazy-sydykov/azure-cloud.git#main:task08/application"
    context_access_token = var.git_pat
    image_names          = ["${var.image_name}:latest"]
  }

  timer_trigger {
    name     = "daily-build"
    schedule = "0 0 * * *"
  }

  tags = var.tags
}

