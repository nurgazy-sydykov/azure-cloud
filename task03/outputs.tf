output "rg_id" {
  description = "Resource Group ID"
  value       = azurerm_resource_group.rg.id
}

output "sa_blob_endpoint" {
  description = "Storage Account blob service primary endpoint"
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}
