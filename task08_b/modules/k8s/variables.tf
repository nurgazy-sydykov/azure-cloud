variable "aks_kv_access_identity_id" {
  description = "User-assigned identity ID used by the AKS CSI driver to access Key Vault."
  type        = string
}

variable "kv_name" {
  description = "Azure Key Vault name."
  type        = string
}

variable "redis_url_secret_name" {
  description = "Secret name for the Redis hostname in Key Vault."
  type        = string
}

variable "redis_password_secret_name" {
  description = "Secret name for the Redis password in Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID."
  type        = string
}

variable "acr_login_server" {
  description = "Azure Container Registry login server."
  type        = string
}

variable "app_image_name" {
  description = "Application image name."
  type        = string
}

variable "image_tag" {
  description = "Image tag used for the deployed application."
  type        = string
  default     = "latest"
}

variable "aks_depends_on" {
  description = "Terraform dependencies that must complete before the k8s manifests are applied."
  type        = any
  default     = []
}
