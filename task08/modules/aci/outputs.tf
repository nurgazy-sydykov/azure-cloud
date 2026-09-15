output "fqdn" {
  description = "The FQDN of the Azure Container Instance."
  value       = azurerm_container_group.aci.fqdn
}
