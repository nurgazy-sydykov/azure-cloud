resource "azurerm_app_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier     = "Standard"
    size     = var.sku_name
    capacity = var.worker_count
  }

  tags = var.tags
}
