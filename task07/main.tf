resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

import {
  to = azurerm_resource_group.rg
  id = "/subscriptions/8da553a7-8f4c-48a2-8701-dafce0b7b79b/resourceGroups/cmtr-3o15j4kj-mod7-rg"
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
  id = "/subscriptions/8da553a7-8f4c-48a2-8701-dafce0b7b79b/resourceGroups/cmtr-3o15j4kj-mod7-rg/providers/Microsoft.Storage/storageAccounts/cmtr3o15j4kjmod7sa"
}

data "azurerm_storage_account" "sa_data" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_container" "container" {
  name                 = "container1"
  storage_account_name = azurerm_storage_account.sa.name
}

import {
  to = azurerm_storage_container.container
  id = "/subscriptions/8da553a7-8f4c-48a2-8701-dafce0b7b79b/resourceGroups/cmtr-3o15j4kj-mod7-rg/providers/Microsoft.Storage/storageAccounts/cmtr3o15j4kjmod7sa/blobServices/default/containers/container1"
}

resource "azurerm_storage_blob" "blob" {
  name                   = var.blob_filename
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
}

import {
  to = azurerm_storage_blob.blob
  id = "/subscriptions/8da553a7-8f4c-48a2-8701-dafce0b7b79b/resourceGroups/cmtr-3o15j4kj-mod7-rg/providers/Microsoft.Storage/storageAccounts/cmtr3o15j4kjmod7sa/blobServices/default/containers/container1/blobs/blob.txt"
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
