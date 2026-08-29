resource "azurerm_traffic_manager_profile" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  traffic_routing_method = var.routing_method

  dns_config {
    relative_name = var.name
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }

  tags = var.tags
}

resource "azurerm_traffic_manager_endpoint" "this" {
  for_each = var.endpoints

  name                = each.value.name
  profile_name        = azurerm_traffic_manager_profile.this.name
  resource_group_name = var.resource_group_name
  type                = "azureEndpoints"
  target              = each.value.target
  endpoint_location   = each.value.location
}
