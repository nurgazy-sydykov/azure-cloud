locals {
  rg_name         = "${var.name_prefix}-rg"
  sql_server_name = "${var.name_prefix}-sql"
  sql_db_name     = "${var.name_prefix}-sql-db"
  asp_name        = "${var.name_prefix}-asp"
  app_name        = "${var.name_prefix}-app"

  kv_rg_name = "${var.name_prefix}-kv-rg"
  kv_name    = "${var.name_prefix}-kv"

  sql_admin_name_secret     = "sql-admin-name"
  sql_admin_password_secret = "sql-admin-password"
}
