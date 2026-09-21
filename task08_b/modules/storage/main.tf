resource "time_static" "sas_start" {
  rfc3339 = timestamp()
}

resource "time_rotating" "sas_expiry" {
  rotation_days = 365
}

data "archive_file" "app" {
  type        = "tar.gz"
  source_dir  = "${path.root}/application"
  output_path = "${path.root}/.terraform/app-content.tar.gz"
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

resource "azurerm_storage_container" "app_content" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "app_archive" {
  name                   = "app.tar.gz"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.app_content.name
  type                   = "Block"
  source                 = data.archive_file.app.output_path
  content_type           = "application/gzip"
}

data "azurerm_storage_account_blob_container_sas" "blob_sas" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  container_name    = azurerm_storage_container.app_content.name
  https_only        = true
  start             = time_static.sas_start.rfc3339
  expiry            = time_rotating.sas_expiry.rfc3339
  permissions {
    read   = true
    write  = false
    list   = true
    add    = false
    create = false
    delete = false
  }
}
