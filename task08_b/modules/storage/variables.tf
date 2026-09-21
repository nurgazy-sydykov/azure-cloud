variable "resource_group_name" {
  description = "Resource group name for the Storage Account."
  type        = string
}

variable "location" {
  description = "Azure location for the storage account."
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name."
  type        = string
}

variable "container_name" {
  description = "Name of the blob container."
  type        = string
}

variable "tags" {
  description = "Resource tags applied to the storage account."
  type        = map(string)
}
