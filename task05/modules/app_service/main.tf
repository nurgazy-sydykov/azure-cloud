resource "azurerm_windows_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id

  site_config {
    ip_restriction {
      name       = "allow-ip"
      ip_address = "18.153.146.156/32" #var.allowed_ip
      action     = "Allow"
      priority   = 100
    }

    ip_restriction {
      name        = "allow-tm"
      service_tag = "AzureTrafficManager" #var.allowed_service_tag
      action      = "Allow"
      priority    = 200
    }

    # Default deny rule
    ip_restriction {
      name    = "deny-all"
      action  = "Deny"
      priority = 300
    }
  }

  tags = var.tags
}
