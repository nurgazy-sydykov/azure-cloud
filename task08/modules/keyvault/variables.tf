variable "rg_name" {
  type        = string
  description = "Resource group where the Key Vault will be deployed."
}

variable "location" {
  type        = string
  description = "Azure region for the Key Vault."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to Key Vault resources."
}

variable "keyvault_name" {
  type        = string
  description = "Name of the Azure Key Vault."
}
