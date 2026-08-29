resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  os_type  = "Windows"   # required in new schema

  sku {
    tier     = "Standard"
    size     = var.sku_name
    capacity = var.worker_count
  }

  tags = var.tags
}
