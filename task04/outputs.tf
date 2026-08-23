output "vm_public_ip" {
  description = "Public IP address of the Virtual Machine"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "vm_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) for the VM public IP"
  value       = azurerm_public_ip.public_ip.fqdn
}
