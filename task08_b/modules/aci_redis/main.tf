resource "random_password" "redis" {
  length           = 24
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>?"
}

resource "azurerm_container_group" "redis" {
  name                = var.redis_aci_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.redis_aci_name
  os_type             = "Linux"
  restart_policy      = "Always"
  tags                = var.tags

  container {
    name   = "redis"
    image  = "mcr.microsoft.com/cbl-mariner/base/redis:6.2.18-3-cm2.0.20250729"
    cpu    = 1
    memory = 2

    ports {
      port     = 6379
      protocol = "TCP"
    }

    commands = [
      "redis-server",
      "--protected-mode",
      "no",
      "--requirepass",
      random_password.redis.result,
    ]
  }
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = azurerm_container_group.redis.fqdn
  key_vault_id = var.key_vault_id

  depends_on = [var.key_vault_access_policy_depends_on]
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = "redis-password"
  value        = random_password.redis.result
  key_vault_id = var.key_vault_id

  depends_on = [var.key_vault_access_policy_depends_on]
}
