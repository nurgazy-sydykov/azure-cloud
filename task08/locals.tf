locals {
  rg_name       = "${var.name_prefix}-rg"
  aci_name      = "${var.name_prefix}-ci"
  acr_name      = "${replace(var.name_prefix, "-", "")}cr"
  aks_name      = "${var.name_prefix}-aks"
  keyvault_name = "${var.name_prefix}-kv"
  redis_name    = "${replace(var.name_prefix, "-mod8", "")}-1789495428-mod8-redis"
  image_name    = "${var.name_prefix}-app"

  redis_hostname_secret_name    = "redis-hostname"
  redis_primary_key_secret_name = "redis-primary-key"

  common_tags = var.tags
}
