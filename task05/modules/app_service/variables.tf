variable "name" {
  type        = string
  description = "Name of the App Service"
}

variable "location" {
  type        = string
  description = "Location of the App Service"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the App Service will be created"
}

variable "app_service_plan_id" {
  type        = string
  description = "ID of the App Service Plan to host this App Service"
}

variable "allowed_ip" {
  type        = string
  description = "IP address allowed to access the App Service"
}

variable "allowed_service_tag" {
  type        = string
  description = "Service tag allowed to access the App Service"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the App Service"
}
