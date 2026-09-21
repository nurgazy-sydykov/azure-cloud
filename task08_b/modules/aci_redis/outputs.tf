output "redis_fqdn" {
  description = "FQDN of Redis in Azure Container Instance."
  value       = azurerm_container_group.redis.fqdn
}

output "redis_ip" {
  description = "Public IP address of the Redis ACI."
  value       = azurerm_container_group.redis.ip_address
}

output "redis_password" {
  description = "Generated Redis password."
  value       = random_password.redis.result
  sensitive   = true
}

output "redis_hostname_secret_id" {
  description = "Key Vault secret ID for the Redis hostname."
  value       = azurerm_key_vault_secret.redis_hostname.id
}

output "redis_password_secret_id" {
  description = "Key Vault secret ID for the Redis password."
  value       = azurerm_key_vault_secret.redis_password.id
}
