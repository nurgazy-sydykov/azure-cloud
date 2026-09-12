variable "location" {
  type        = string
  description = "Azure region for all resources."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the existing Resource Group."
}

variable "resource_group_id" {
  type        = string
  description = "Resource ID of the existing Resource Group."
}

variable "storage_account_name" {
  type        = string
  description = "Name of the existing Storage Account."
}

variable "storage_account_id" {
  type        = string
  description = "Resource ID of the existing Storage Account."
}

variable "blob_filename" {
  type        = string
  description = "Blob filename stored in the Storage Account."
}

variable "fd_profile_name" {
  type        = string
  description = "Azure Front Door profile name."
}

variable "fd_profile_sku" {
  type        = string
  description = "Azure Front Door profile SKU."
}

variable "fd_endpoint_name" {
  type        = string
  description = "Azure Front Door endpoint name."
}

variable "fd_origin_group_name" {
  type        = string
  description = "Azure Front Door origin group name."
}

variable "fd_origin_name" {
  type        = string
  description = "Azure Front Door origin name."
}

variable "fd_route_name" {
  type        = string
  description = "Azure Front Door route name."
}
