variable "name" {
  type        = string
  description = "Name of the Traffic Manager profile"
}

variable "location" {
  type        = string
  description = "Location of the Traffic Manager profile"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the Traffic Manager profile will be created"
}

variable "routing_method" {
  type        = string
  description = "Routing method for Traffic Manager (Performance, Priority, etc.)"
}

variable "endpoints" {
  type = map(object({
    name   = string
    target = string
  }))
  description = "Map of Traffic Manager endpoints (name + target resource ID)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Traffic Manager profile"
}
