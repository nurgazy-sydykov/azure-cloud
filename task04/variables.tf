variable "rg_name" {
  description = "Name of the resource group to create"
  type        = string
}

variable "location" {
  description = "Azure location for all resources"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet (standalone resource)"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "nsg_rule_http" {
  description = "Name of the NSG rule allowing HTTP inbound"
  type        = string
}

variable "nsg_rule_ssh" {
  description = "Name of the NSG rule allowing SSH inbound"
  type        = string
}

variable "public_ip" {
  description = "Name of the Public IP resource"
  type        = string
}

variable "domain_name_label" {
  description = "DNS name label for the public IP (will form FQDN)"
  type        = string
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "vm_SKU" {
  description = "VM size (SKU) e.g. Standard_B1s"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the Linux VM"
  type        = string
  default     = "azureuser"
}

variable "vm_password" {
  description = "Admin password for the Linux VM (sensitive)"
  type        = string
  sensitive   = true
}

variable "student_email" {
  description = "Email/address used for Creator tag"
  type        = string
}

# Image selection (separate variables so values are configurable)
variable "vm_os_publisher" {
  description = "Image publisher for the VM"
  type        = string
  default     = "Canonical"
}

variable "vm_os_offer" {
  description = "Image offer for the VM"
  type        = string
  default     = "UbuntuServer"
}

variable "vm_os_sku" {
  description = "Image SKU for the VM"
  type        = string
  default     = "20_04-lts"
}

variable "ip_configuration_name" {
  description = "IP configuration name for NIC"
  type        = string
}
variable "vm_os_version" {
  description = "Image version for the VM (use \"latest\" by default)"
  type        = string
  default     = "latest"
}
