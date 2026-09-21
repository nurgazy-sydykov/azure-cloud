variable "name_prefix" {
  description = "Prefix used to generate Azure resource names."
  type        = string
  default     = "cmtr-3o15j4kj-mod8b"
}

variable "location" {
  description = "Azure region for all resources in this task."
  type        = string
  default     = "centralindia"
}

variable "app_image_name" {
  description = "Name of the Docker image pushed to Azure Container Registry."
  type        = string
  default     = "cmtr-3o15j4kj-mod8b-app"
}
