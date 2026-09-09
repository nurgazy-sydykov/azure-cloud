# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.region
  tags     = var.tags
}

# Data source for existing Key Vault
data "azurerm_key_vault" "kv" {
  name                = local.kv_name
  resource_group_name = local.kv_rg_name
}

# SQL Module
module "sql" {
  source = "./modules/sql"

  rg_name                  = azurerm_resource_group.rg.name
  region                   = var.region
  sql_server_name          = local.sql_server_name
  sql_db_name              = local.sql_db_name
  sql_db_sku               = "S2"
  sql_admin_username       = var.sql_admin_username
  allowed_ip_address       = var.allowed_ip_address
  sql_firewall_rule_name   = "allow-verification-ip"
  key_vault_id             = data.azurerm_key_vault.kv.id
  sql_admin_name_secret    = local.sql_admin_name_secret
  sql_admin_password_secret= local.sql_admin_password_secret
  tags                     = var.tags
}

# WebApp Module
module "webapp" {
  source = "./modules/webapp"

  rg_name             = azurerm_resource_group.rg.name
  region              = var.region
  asp_name            = local.asp_name
  asp_sku             = "P0v3"
  app_name            = local.app_name
  dotnet_version      = "8.0"
  sql_connection_string = module.sql.sql_connection_string
  tags                = var.tags
}
