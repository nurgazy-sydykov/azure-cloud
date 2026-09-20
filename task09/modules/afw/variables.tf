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

variable "firewall_subnet_address" {
  type        = string
  description = "Address prefix for the required AzureFirewallSubnet."
}

variable "name_prefix" {
  type        = string
  description = "Naming prefix for resources created by this module."
}

variable "firewall_public_ip_name" {
  type        = string
  description = "Azure Firewall public IP resource name."
}

variable "firewall_name" {
  type        = string
  description = "Azure Firewall resource name."
}

variable "route_table_name" {
  type        = string
  description = "Route table resource name."
}

variable "firewall_ip_configuration" {
  type        = string
  description = "Azure Firewall IP configuration name."
}

variable "application_rule_collection" {
  type        = string
  description = "Application rule collection name."
}

variable "network_rule_collection" {
  type        = string
  description = "Network rule collection name."
}

variable "nat_rule_collection" {
  type        = string
  description = "NAT rule collection name."
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "AKS load balancer public IP used as the DNAT target."
}
