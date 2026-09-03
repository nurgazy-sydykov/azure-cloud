# -------------------------
# Resource Groups
# -------------------------
module "rg" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = { Creator = "nurgazy_sydykov@epam.com" }
}

# -------------------------
# App Service Plans
# -------------------------
module "asp" {
  source   = "./modules/app_service_plan"
  for_each = var.app_service_plans

  name                = each.value.name
  location            = module.rg[each.value.rg_key].location
  resource_group_name = module.rg[each.value.rg_key].name
  sku_name            = each.value.sku
  worker_count        = each.value.worker_count
  tags                = { Creator = "nurgazy_sydykov@epam.com" }
}

# -------------------------
# Windows Web Apps
# -------------------------
module "app" {
  source   = "./modules/app_service"
  for_each = var.app_services

  name                = each.value.name
  location            = module.rg[each.value.rg_key].location
  resource_group_name = module.rg[each.value.rg_key].name
  app_service_plan_id = module.asp[each.value.asp_key].id

  allowed_ip          = var.allowed_ip
  allowed_service_tag = var.allowed_service_tag

  tags = { Creator = "nurgazy_sydykov@epam.com" }
}

# -------------------------
# Traffic Manager Profile
# -------------------------
module "traffic_manager" {
  source = "./modules/traffic_manager"

  name                = var.traffic_manager.name
  location            = module.rg["rg3"].location
  resource_group_name = module.rg["rg3"].name
  routing_method      = var.traffic_manager.routing_method

  endpoints = {
    app1 = {
      name   = "endpoint-app1"
      target = module.app["app1"].id
    }
    app2 = {
      name   = "endpoint-app2"
      target = module.app["app2"].id
    }
  }

  tags = { Creator = "nurgazy_sydykov@epam.com" }
}
