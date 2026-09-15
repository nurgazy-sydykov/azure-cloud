variable "rg_name" {
  type        = string
  description = "Resource group where AKS will be deployed."
}

variable "location" {
  type        = string
  description = "Azure region for AKS."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to AKS resources."
}

variable "aks_name" {
  type        = string
  description = "Name of the AKS cluster."
}

variable "acr_id" {
  type        = string
  description = "ID of the Azure Container Registry for image pulls."
}

variable "keyvault_id" {
  type        = string
  description = "ID of the Key Vault for secret access."
}
