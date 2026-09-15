output "id" {
  description = "The ID of the Redis Cache instance."
  value       = azurerm_redis_cache.redis.id
}

output "redis_hostname_secret" {
  description = "The Key Vault secret resource for Redis hostname."
  value       = azurerm_key_vault_secret.redis_hostname.id
}

output "redis_primary_key_secret" {
  description = "The Key Vault secret resource for Redis primary key."
  value       = azurerm_key_vault_secret.redis_primary_key.id
}
