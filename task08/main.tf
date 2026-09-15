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
  image_name = "${var.name_prefix}-app"
  git_pat    = var.git_pat
}

module "keyvault" {
  source = "./modules/keyvault"

  rg_name        = azurerm_resource_group.rg.name
  location       = var.location
  tags           = local.common_tags
  keyvault_name  = local.keyvault_name
}

module "redis" {
  source = "./modules/redis"

  rg_name       = azurerm_resource_group.rg.name
  location      = var.location
  tags          = local.common_tags
  redis_name    = local.redis_name
  keyvault_id   = module.keyvault.id
  kv_secret_host = "redis-hostname"
  kv_secret_key  = "redis-primary-key"
}

module "aks" {
  source = "./modules/aks"

  rg_name        = azurerm_resource_group.rg.name
  location       = var.location
  tags           = local.common_tags

  aks_name       = local.aks_name
  acr_id         = module.acr.id
  keyvault_id    = module.keyvault.id
}

module "aci" {
  source = "./modules/aci"

  rg_name        = azurerm_resource_group.rg.name
  location       = var.location
  tags           = local.common_tags

  aci_name       = local.aci_name
  image_name     = module.acr.image_name
  acr_login_server = module.acr.login_server

  redis_hostname_secret = module.redis.redis_hostname_secret
  redis_primary_key_secret = module.redis.redis_primary_key_secret
}

# Deployment manifest
resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    image_name = "${module.acr.login_server}/${module.acr.image_name}:latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [module.aks]
}

# Secret provider manifest
resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    keyvault_name = local.keyvault_name
  })

  depends_on = [module.aks]
}

# Service manifest
resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [module.aks]
}

data "kubernetes_service" "app_service" {
  metadata {
    name      = "app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.service]
}
