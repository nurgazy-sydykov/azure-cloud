variable "name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "location" {
  type        = string
  description = "Location of the App Service Plan"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the plan will be created"
}

variable "sku_name" {
  type        = string
  description = "SKU name (e.g., S1)"
}

variable "worker_count" {
  type        = number
  description = "Number of workers/instances"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the App Service Plan"
}
