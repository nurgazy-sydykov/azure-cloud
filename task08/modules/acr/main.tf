resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Basic"

  admin_enabled = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                = "${var.acr_name}-build-task"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os = "Linux"
  }

  agent_configuration {
    cpu = 2
  }

  docker_step {
    context_path         = "https://github.com/nurgazy-sydykov/azure-cloud.git"
    context_access_token = var.git_pat
    image_names          = ["${var.image_name}:latest"]
  }

  tags = var.tags
}

resource "azurerm_container_registry_task_schedule_run" "schedule" {
  container_registry_task_id = azurerm_container_registry_task.build_task.id
  cron_expression            = "0 */6 * * *" # every 6 hours

  tags = var.tags
}
