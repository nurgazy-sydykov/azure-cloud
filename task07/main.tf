resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

import {
  to = azurerm_resource_group.rg
  id = var.resource_group_id
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
}

import {
  to = azurerm_storage_account.sa
  id = var.storage_account_id
}

data "azurerm_storage_account" "sa_data" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

module "cdn" {
  source = "./modules/cdn"

  location             = var.location
  resource_group_name  = var.resource_group_name
  fd_profile_name      = var.fd_profile_name
  fd_profile_sku       = var.fd_profile_sku
  fd_endpoint_name     = var.fd_endpoint_name
  fd_origin_group_name = var.fd_origin_group_name
  fd_origin_name       = var.fd_origin_name
  fd_route_name        = var.fd_route_name

  origin_hostname = data.azurerm_storage_account.sa_data.primary_blob_host
  blob_path       = local.blob_path
}
