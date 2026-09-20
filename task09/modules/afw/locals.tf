locals {
  firewall_subnet_name = "AzureFirewallSubnet"
  firewall_public_ip   = azurerm_public_ip.firewall.ip_address
  firewall_private_ip  = azurerm_firewall.main.ip_configuration[0].private_ip_address

  application_protocols = [
    {
      type = "Http"
      port = 80
    },
    {
      type = "Https"
      port = 443
    }
  ]

  network_protocols = ["TCP", "UDP"]
}
