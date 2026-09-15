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
