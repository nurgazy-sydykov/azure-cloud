locals {
  name_prefix    = var.name_prefix
  rg_name        = "${var.name_prefix}-rg"
  aca_name       = "${var.name_prefix}-ca"
  aca_env_name   = "${var.name_prefix}-cae"
  acr_name       = lower(replace("${var.name_prefix}cr", "-", ""))
  aks_name       = "${var.name_prefix}-aks"
  keyvault_name  = "${var.name_prefix}-kv"
  redis_aci_name = "${var.name_prefix}-redis-ci"
  sa_name        = lower(replace("${var.name_prefix}sa", "-", ""))
  app_image_name = var.app_image_name
  tags = {
    Creator = "nurgazy_sydykov@epam.com"
  }
}
