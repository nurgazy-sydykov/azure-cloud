variable "resource_group_name" {
  description = "Resource group where the Key Vault is created."
  type        = string
}

variable "location" {
  description = "Azure region for the Key Vault."
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID used by the Key Vault resource."
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of the current user for admin access policy."
  type        = string
}

variable "tags" {
  description = "Tags applied to the Key Vault resource."
  type        = map(string)
}
