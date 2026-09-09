variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "region" {
  description = "Azure region"
  type        = string
}

variable "sql_server_name" {
  description = "SQL Server name"
  type        = string
}

variable "sql_db_name" {
  description = "SQL Database name"
  type        = string
}

variable "sql_db_sku" {
  description = "SQL Database SKU"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL administrator username"
  type        = string
}

variable "allowed_ip_address" {
  description = "Allowed IP address for firewall rule"
  type        = string
}

variable "sql_firewall_rule_name" {
  description = "Firewall rule name"
  type        = string
}

variable "key_vault_id" {
  description = "Existing Key Vault ID"
  type        = string
}

variable "sql_admin_name_secret" {
  description = "Key Vault secret name for SQL admin username"
  type        = string
}

variable "sql_admin_password_secret" {
  description = "Key Vault secret name for SQL admin password"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
