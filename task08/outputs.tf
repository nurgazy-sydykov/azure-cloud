output "aci_fqdn" {
  description = "FQDN of the application deployed in Azure Container Instance."
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "Load Balancer IP address of the application deployed in AKS."
  value       = data.kubernetes_service_v1.app.status[0].load_balancer[0].ingress[0].ip
}

