variable "rg_name" {
  type        = string
  description = "Resource group where Redis will be deployed."
}

variable "location" {
  type        = string
  description = "Azure region for Redis."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to Redis resources."
}

variable "redis_name" {
  type        = string
  description = "Name of the Azure Redis Cache instance."
}

variable "keyvault_id" {
  type        = string
  description = "ID of the Key Vault where Redis secrets will be stored."
}

variable "kv_secret_host" {
  type        = string
  description = "Name of the Key Vault secret for Redis hostname."
}

variable "kv_secret_key" {
  type        = string
  description = "Name of the Key Vault secret for Redis primary key."
}
