# Resource Groups
variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
  description = "Map of resource groups"
}

# App Service Plans
variable "app_service_plans" {
  type = map(object({
    name         = string
    sku          = string
    worker_count = number
    rg_key       = string # key to link with resource_groups
  }))
  description = "Map of App Service Plans"
}

# App Services
variable "app_services" {
  type = map(object({
    name    = string
    rg_key  = string # key to link with resource_groups
    asp_key = string # key to link with app_service_plans
  }))
  description = "Map of App Services"
}

# Traffic Manager
variable "traffic_manager" {
  type = object({
    name           = string
    routing_method = string
  })
  description = "Traffic Manager profile configuration"
}
