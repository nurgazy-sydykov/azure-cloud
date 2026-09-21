output "name" {
  description = "Name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "host" {
  description = "AKS host endpoint."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
}

output "client_certificate" {
  description = "AKS client certificate."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
}

output "client_key" {
  description = "AKS client secret key."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
}

output "cluster_ca_certificate" {
  description = "AKS cluster CA certificate."
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
}

output "kv_access_identity_id" {
  description = "The user-assigned identity ID used by AKS to access Key Vault secrets."
  value       = azurerm_user_assigned_identity.aks.id
}
