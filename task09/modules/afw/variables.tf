variable "location" {
  type        = string
  description = "Azure region for the firewall resources."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the firewall resources."
}

variable "virtual_network_name" {
  type        = string
  description = "Existing virtual network name."
}

variable "aks_subnet_id" {
  type        = string
  description = "Existing AKS subnet resource ID."
}

variable "virtual_network_address_space" {
  type        = string
  description = "Address space of the existing virtual network."
}

variable "name_prefix" {
  type        = string
  description = "Naming prefix for resources created by this module."
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "AKS load balancer public IP used as the DNAT target."
}
