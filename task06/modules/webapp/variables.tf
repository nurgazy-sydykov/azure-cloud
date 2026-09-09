variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "region" {
  description = "Azure region"
  type        = string
}

variable "asp_name" {
  description = "App Service Plan name"
  type        = string
}

variable "asp_sku" {
  description = "App Service Plan SKU"
  type        = string
}

variable "app_name" {
  description = "Web Application name"
  type        = string
}

variable "dotnet_version" {
  description = "Dotnet version for the Web App"
  type        = string
}

variable "sql_connection_string" {
  description = "SQL Database connection string"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
