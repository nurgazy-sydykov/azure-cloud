resource "azurerm_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows"
  sku_name            = var.pricing_tier
  worker_count        = var.worker_count
  tags                = var.tags
}
