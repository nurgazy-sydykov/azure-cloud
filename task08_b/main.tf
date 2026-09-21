data "azurerm_client_config" "current" {}

resource "azurerm_resource_provider_registration" "app" {
  name = "Microsoft.App"
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_log_analytics_workspace" "aca" {
  name                = "${var.name_prefix}-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}

module "storage" {
  source               = "./modules/storage"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_name = local.sa_name
  container_name       = "app-content"
  tags                 = local.tags
}

module "keyvault" {
  source                 = "./modules/keyvault"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  key_vault_name         = local.keyvault_name
  tenant_id              = data.azurerm_client_config.current.tenant_id
  current_user_object_id = data.azurerm_client_config.current.object_id
  tags                   = local.tags
}

module "aci_redis" {
  source                             = "./modules/aci_redis"
  resource_group_name                = azurerm_resource_group.rg.name
  location                           = azurerm_resource_group.rg.location
  redis_aci_name                     = local.redis_aci_name
  key_vault_id                       = module.keyvault.id
  key_vault_access_policy_depends_on = [module.keyvault]
  tags                               = local.tags
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  acr_name            = local.acr_name
  app_image_name      = local.app_image_name
  blob_url            = module.storage.blob_url
  blob_sas_token      = module.storage.blob_sas_token
  archive_dependency  = [module.storage]
  tags                = local.tags
}

module "aks" {
  source                         = "./modules/aks"
  name_prefix                    = var.name_prefix
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = azurerm_resource_group.rg.location
  aks_name                       = local.aks_name
  default_node_pool_name         = "system"
  default_node_pool_count        = 1
  default_node_pool_vm_size      = "Standard_D2ads_v6"
  default_node_pool_os_disk_type = "Ephemeral"
  tags                           = local.tags
  acr_id                         = module.acr.id
  key_vault_id                   = module.keyvault.id
  tenant_id                      = data.azurerm_client_config.current.tenant_id
}

module "aca" {
  source                     = "./modules/aca"
  name_prefix                = var.name_prefix
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  tags                       = local.tags
  aca_name                   = local.aca_name
  aca_env_name               = local.aca_env_name
  key_vault_id               = module.keyvault.id
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  acr_id                     = module.acr.id
  acr_login_server           = module.acr.login_server
  app_image_name             = local.app_image_name
  redis_hostname_secret_id   = module.aci_redis.redis_hostname_secret_id
  redis_password_secret_id   = module.aci_redis.redis_password_secret_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aca.id
  depends_on                 = [azurerm_resource_provider_registration.app]
}

module "k8s" {
  source                     = "./modules/k8s"
  aks_kv_access_identity_id  = module.aks.kv_access_identity_id
  kv_name                    = module.keyvault.name
  redis_url_secret_name      = "redis-hostname"
  redis_password_secret_name = "redis-password"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  acr_login_server           = module.acr.login_server
  app_image_name             = local.app_image_name
  image_tag                  = "latest"
  aks_depends_on             = [module.aks, module.keyvault, module.aci_redis]
}
