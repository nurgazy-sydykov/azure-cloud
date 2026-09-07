# -------------------------
# Resource Groups
# -------------------------
module "rg" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = { (var.tag_key) = var.tag_value }
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
  tags                = { (var.tag_key) = var.tag_value }
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

  ip_restrictions = var.ip_restrictions

  tags = { (var.tag_key) = var.tag_value }
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

  tags = { (var.tag_key) = var.tag_value }
}
