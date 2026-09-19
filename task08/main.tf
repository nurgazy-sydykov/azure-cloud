############################################
# Resource Group
############################################

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

############################################
# Modules
############################################

module "acr" {
  source = "./modules/acr"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  tags     = local.common_tags

  acr_name   = local.acr_name
  image_name = local.image_name
  git_pat    = var.git_pat
}

module "keyvault" {
  source = "./modules/keyvault"

  rg_name       = azurerm_resource_group.rg.name
  location      = var.location
  tags          = local.common_tags
  keyvault_name = local.keyvault_name
}

module "redis" {
  source = "./modules/redis"

  rg_name        = azurerm_resource_group.rg.name
  location       = var.location
  tags           = local.common_tags
  redis_name     = local.redis_name
  keyvault_id    = module.keyvault.id
  kv_secret_host = local.redis_hostname_secret_name
  kv_secret_key  = local.redis_primary_key_secret_name
}

module "aks" {
  source = "./modules/aks"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  tags     = local.common_tags

  aks_name    = local.aks_name
  acr_id      = module.acr.id
  keyvault_id = module.keyvault.id
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = module.aks.aks_name
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [module.aks]
}

module "aci" {
  source = "./modules/aci"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  tags     = local.common_tags

  aci_name         = local.aci_name
  image_name       = module.acr.image_name
  acr_login_server = module.acr.login_server
  acr_username     = module.acr.admin_username
  acr_password     = module.acr.admin_password

  redis_hostname_secret    = module.redis.redis_hostname_secret
  redis_primary_key_secret = module.redis.redis_primary_key_secret
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kv_secret_identity_client_id
    kv_name                    = local.keyvault_name
    redis_url_secret_name      = local.redis_hostname_secret_name
    redis_password_secret_name = local.redis_primary_key_secret_name
    tenant_id                  = module.aks.tenant_id
  })

  depends_on = [module.aks, module.keyvault, module.redis]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.login_server
    app_image_name   = module.acr.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.acr]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service_v1" "app" {
  metadata {
    name = "redis-flask-app-service"
  }

  depends_on = [kubectl_manifest.service]
}
