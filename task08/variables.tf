variable "name_prefix" {
  type        = string
  description = "Base prefix used to construct resource names (e.g. cmtr-3o15j4kj-mod8)."
}

variable "location" {
  type        = string
  description = "Azure region where all resources will be deployed."
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all supported resources."
}

variable "git_pat" {
  type        = string
  description = "Sensitive Git personal access token used by ACR task to access the source repository."
  sensitive   = true
}
