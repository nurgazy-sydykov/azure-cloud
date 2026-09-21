output "storage_account_name" {
  description = "Storage account name."
  value       = azurerm_storage_account.sa.name
}

output "container_name" {
  description = "Container name holding the archived app content."
  value       = azurerm_storage_container.app_content.name
}

output "blob_url" {
  description = "Blob URL for the archived application."
  value       = "https://${azurerm_storage_account.sa.name}.blob.core.windows.net/${azurerm_storage_container.app_content.name}/${azurerm_storage_blob.app_archive.name}"
}

output "blob_sas_token" {
  description = "SAS token used to access the archive blob."
  value       = data.azurerm_storage_account_blob_container_sas.blob_sas.sas
  sensitive   = true
}
