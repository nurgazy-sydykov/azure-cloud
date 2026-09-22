output "redis_fqdn" {
  description = "FQDN of the Redis Azure Container Instance."
  value       = module.aci_redis.redis_fqdn
}

output "aca_fqdn" {
  description = "FQDN of the Azure Container App."
  value       = module.aca.aca_fqdn
}

output "aks_lb_ip" {
  description = "Load balancer public IP for the AKS application."
  value       = module.k8s.aks_lb_ip
}

output "blob_url" {
  value = module.storage.blob_url
}

output "blob_sas_token" {
  value     = module.storage.blob_sas_token
  sensitive = true
}
