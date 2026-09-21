output "aca_name" {
  description = "Azure Container App name."
  value       = azurerm_container_app.aca.name
}

output "aca_fqdn" {
  description = "FQDN of the Azure Container App."
  value       = azurerm_container_app.aca.latest_revision_fqdn
}

output "aca_identity_principal_id" {
  description = "Principal ID of the ACA user-assigned identity."
  value       = azurerm_user_assigned_identity.aca.principal_id
}
