variable "rg_name" {
  type        = string
  description = "Resource group where ACI will be deployed."
}

variable "location" {
  type        = string
  description = "Azure region for ACI."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to ACI resources."
}

variable "aci_name" {
  type        = string
  description = "Name of the Azure Container Instance."
}

variable "image_name" {
  type        = string
  description = "Name of the Docker image to run."
}

variable "acr_login_server" {
  type        = string
  description = "Login server of the Azure Container Registry."
}

variable "acr_username" {
  type        = string
  description = "Admin username of the Azure Container Registry."
}

variable "acr_password" {
  type        = string
  sensitive   = true
  description = "Admin password of the Azure Container Registry."
}

variable "redis_hostname_secret" {
  type        = string
  description = "Key Vault secret ID for Redis hostname."
}

variable "redis_primary_key_secret" {
  type        = string
  description = "Key Vault secret ID for Redis primary key."
}
