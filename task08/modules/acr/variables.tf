variable "rg_name" {
  type        = string
  description = "Name of the resource group where ACR will be deployed."
}

variable "location" {
  type        = string
  description = "Azure region for ACR."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to ACR resources."
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry."
}

variable "image_name" {
  type        = string
  description = "Name of the Docker image to build using ACR Task."
}

variable "git_pat" {
  type        = string
  sensitive   = true
  description = "Git Personal Access Token used by ACR Task to access the source repository."
}
