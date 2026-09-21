resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = "Basic"
  admin_enabled                 = false
  public_network_access_enabled = true
  tags                          = var.tags
}

resource "azurerm_container_registry_task" "build" {
  name                  = "build-${var.app_image_name}"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.blob_url
    context_access_token = var.blob_sas_token
    image_names          = ["${azurerm_container_registry.acr.login_server}/${var.app_image_name}:latest"]
    push_enabled         = true
  }

  depends_on = [var.archive_dependency]
}

resource "azurerm_container_registry_task_schedule_run_now" "build_now" {
  container_registry_task_id = azurerm_container_registry_task.build.id
}
