variable "resource_group_name" {
  description = "Name of the resource group where the ACR is created."
  type        = string
}

variable "location" {
  description = "Azure region for the ACR."
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry."
  type        = string
}

variable "app_image_name" {
  description = "Docker image name to be built in the registry."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Azure Container Registry."
  type        = map(string)
}

variable "blob_url" {
  description = "Blob URL used as the build context for the registry task."
  type        = string
}

variable "blob_sas_token" {
  description = "SAS token used to access the source blob from the build context."
  type        = string
}

