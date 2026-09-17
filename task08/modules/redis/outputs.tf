output "id" {
  description = "The ID of the Redis Cache instance."
  value       = azurerm_redis_cache.redis.id
}

output "redis_hostname_secret" {
  description = "The Redis hostname stored in Key Vault."
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_primary_key_secret" {
  description = "The Redis primary access key stored in Key Vault."
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}
