variable "location" {
  type        = string
  description = "Azure region for resources created by this configuration."
}

variable "resource_group_name" {
  type        = string
  description = "Existing resource group containing the AKS cluster and virtual network."
}

variable "virtual_network_name" {
  type        = string
  description = "Existing virtual network containing the AKS subnet."
}

variable "aks_subnet_name" {
  type        = string
  description = "Existing subnet used by the AKS cluster."
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "Public IP address of the AKS load balancer used by the NGINX service."
}
