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

resource "azurerm_traffic_manager_azure_endpoint" "this" {
  for_each = var.endpoints

  name       = each.value.name
  profile_id = azurerm_traffic_manager_profile.this.id
  target_resource_id = each.value.target
}
