variable "name_prefix" {
  description = "Prefix used to build Azure resource names."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where ACA resources are deployed."
  type        = string
}

variable "location" {
  description = "Azure region for the ACA resources."
  type        = string
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
}

variable "aca_name" {
  description = "Name of the Azure Container App."
  type        = string
}

variable "aca_env_name" {
  description = "Name of the Azure Container App Environment."
  type        = string
}

variable "key_vault_id" {
  description = "The Key Vault resource id used by ACA to fetch secrets."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID used for the Key Vault access policy."
  type        = string
}

variable "acr_id" {
  description = "Resource ID of the Azure Container Registry used by the app."
  type        = string
}

variable "acr_login_server" {
  description = "Container Registry login server."
  type        = string
}

variable "app_image_name" {
  description = "Image name stored in Azure Container Registry."
  type        = string
}

variable "redis_hostname_secret_id" {
  description = "Versioned Key Vault secret ID for Redis hostname."
  type        = string
}

variable "redis_password_secret_id" {
  description = "Versioned Key Vault secret ID for Redis password."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID used by ACA Environment."
  type        = string
}
