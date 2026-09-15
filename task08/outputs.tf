output "aci_fqdn" {
  description = "FQDN of the application deployed in Azure Container Instance."
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "LoadBalancer IP address of the application deployed in AKS."
  value       = data.kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip
}
