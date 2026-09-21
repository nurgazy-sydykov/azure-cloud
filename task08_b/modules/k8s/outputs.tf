output "aks_lb_ip" {
  description = "Public IP address exposed by the Kubernetes service."
  value       = data.kubernetes_service_v1.app.status[0].load_balancer[0].ingress[0].ip
}
