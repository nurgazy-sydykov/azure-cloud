resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                = var.fd_profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.fd_profile_sku
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  name                = var.fd_endpoint_name
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_cdn_frontdoor_profile.fd_profile.name
}

resource "azurerm_cdn_frontdoor_origin_group" "fd_origin_group" {
  name                = var.fd_origin_group_name
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_cdn_frontdoor_profile.fd_profile.name
}

resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  name                     = var.fd_origin_name
  resource_group_name      = var.resource_group_name
  profile_name             = azurerm_cdn_frontdoor_profile.fd_profile.name
  origin_group_name        = azurerm_cdn_frontdoor_origin_group.fd_origin_group.name

  host_name                = var.origin_hostname
  http_port                = 80
  https_port               = 443
}

resource "azurerm_cdn_frontdoor_route" "fd_route" {
  name                = var.fd_route_name
  resource_group_name = var.resource_group_name
  profile_name        = azurerm_cdn_frontdoor_profile.fd_profile.name
  endpoint_name       = azurerm_cdn_frontdoor_endpoint.fd_endpoint.name

  origin_group_name   = azurerm_cdn_frontdoor_origin_group.fd_origin_group.name

  patterns_to_match = [
    var.blob_path
  ]

  supported_protocols = ["Http", "Https"]
  forwarding_protocol = "MatchRequest"
}
