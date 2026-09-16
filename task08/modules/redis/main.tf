resource "azurerm_redis_cache" "redis" {
  name                = var.redis_name
  location            = var.location
  resource_group_name = var.rg_name
  capacity            = 2
  family              = "C"
  sku_name            = "Basic"

  non_ssl_port_enabled = false

  tags = var.tags
}

# Store Redis hostname in Key Vault
resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.kv_secret_host
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_redis_cache.redis]
}

# Store Redis primary key in Key Vault
resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.kv_secret_key
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_redis_cache.redis]
}
