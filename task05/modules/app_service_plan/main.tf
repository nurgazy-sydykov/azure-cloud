resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name
  os_type  = "Windows"
  capacity = var.worker_count

  tags = var.tags
}
