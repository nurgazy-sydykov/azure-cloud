resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.region
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_admin.result
  tags                         = var.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name                = "allow-azure-services"
  server_id           = azurerm_mssql_server.sql_server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "allow_verification_ip" {
  name              = var.sql_firewall_rule_name
  server_id         = azurerm_mssql_server.sql_server.id
  start_ip_address  = var.allowed_ip_address
  end_ip_address    = var.allowed_ip_address
}

resource "azurerm_mssql_database" "sql_db" {
  name                = var.sql_db_name
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = var.sql_db_sku
  tags                = var.tags
}

resource "random_password" "sql_admin" {
  length           = 16
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "azurerm_key_vault_secret" "sql_admin_name_secret" {
  name         = var.sql_admin_name_secret
  value        = var.sql_admin_username
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sql_admin_password_secret" {
  name         = var.sql_admin_password_secret
  value        = random_password.sql_admin.result
  key_vault_id = var.key_vault_id
}
