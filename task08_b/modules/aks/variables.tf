variable "name_prefix" {
  description = "Prefix used to generate AKS-related names."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name used for the AKS cluster."
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster."
  type        = string
}

variable "aks_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "default_node_pool_name" {
  description = "AKS default node pool name."
  type        = string
}

variable "default_node_pool_count" {
  description = "AKS default node pool size."
  type        = number
}

variable "default_node_pool_vm_size" {
  description = "VM size for the default AKS node pool."
  type        = string
}

variable "default_node_pool_os_disk_type" {
  description = "OS disk type for the default AKS node pool."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to deploy."
  type        = string
  default     = "1.29.7"
}

variable "tags" {
  description = "Tags applied to AKS resources."
  type        = map(string)
}

variable "acr_id" {
  description = "Resource ID of the ACR used by AKS."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID used for AKS CSI and secret access."
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID used for Key Vault access."
  type        = string
}
