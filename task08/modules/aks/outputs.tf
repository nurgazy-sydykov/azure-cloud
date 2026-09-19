output "id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  description = "The raw kubeconfig for the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kv_secret_identity_client_id" {
  description = "Client ID of the AKS Key Vault Secrets Provider identity."
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "kv_secret_identity_object_id" {
  description = "Object ID of the AKS Key Vault Secrets Provider identity."
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id
}

output "kv_secret_identity_resource_id" {
  description = "Resource ID of the AKS Key Vault Secrets Provider identity."
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].user_assigned_identity_id
}

output "tenant_id" {
  description = "Tenant ID used by the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
}
