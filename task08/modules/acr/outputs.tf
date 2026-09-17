output "id" {
  description = "The ID of the Azure Container Registry."
  value       = azurerm_container_registry.acr.id
}

output "login_server" {
  description = "The login server URL of the ACR."
  value       = azurerm_container_registry.acr.login_server
}

output "image_name" {
  description = "The name of the built Docker image."
  value       = var.image_name
}

output "admin_username" {
  description = "The ACR admin username for container registry authentication."
  value       = azurerm_container_registry.acr.admin_username
}

output "admin_password" {
  description = "The ACR admin password for container registry authentication."
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}
