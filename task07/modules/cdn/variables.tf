variable "location" {
  type        = string
  description = "Azure region for CDN resources."
}

variable "fd_profile_name" {
  type        = string
  description = "Front Door profile name."
}

variable "fd_profile_sku" {
  type        = string
  description = "Front Door profile SKU."
}

variable "fd_endpoint_name" {
  type        = string
  description = "Front Door endpoint name."
}

variable "fd_origin_group_name" {
  type        = string
  description = "Front Door origin group name."
}

variable "fd_origin_name" {
  type        = string
  description = "Front Door origin name."
}

variable "fd_route_name" {
  type        = string
  description = "Front Door route name."
}

variable "origin_hostname" {
  type        = string
  description = "Hostname of the Storage Account blob endpoint."
}

variable "blob_path" {
  type        = string
  description = "Path to the blob file."
}
