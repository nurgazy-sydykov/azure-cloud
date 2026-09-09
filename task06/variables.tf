variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "region" {
  description = "Azure region for deployment"
  type        = string
}

variable "allowed_ip_address" {
  description = "Public IP address allowed to access SQL Server"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL administrator username"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
