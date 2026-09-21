variable "resource_group_name" {
  description = "Resource group name where the Redis ACI instance will be created."
  type        = string
}

variable "location" {
  description = "Azure region for Redis ACI."
  type        = string
}

variable "redis_aci_name" {
  description = "Redis ACI instance name."
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault resource ID where Redis secrets will be stored."
  type        = string
}

variable "key_vault_access_policy_depends_on" {
  description = "Dependency list ensuring Key Vault access policy exists before writing secrets."
  type        = any
  default     = []
}

variable "tags" {
  description = "Azure resource tags applied to Redis ACI."
  type        = map(string)
}
