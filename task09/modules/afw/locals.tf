locals {
  firewall_subnet_name        = "AzureFirewallSubnet"
  firewall_subnet_cidr        = cidrsubnet(var.virtual_network_address_space, 2, 1)
  firewall_public_ip          = azurerm_public_ip.firewall.ip_address
  firewall_private_ip         = azurerm_firewall.main.ip_configuration[0].private_ip_address
  firewall_public_ip_name     = format("%s-%s", var.name_prefix, "pip")
  firewall_name               = format("%s-%s", var.name_prefix, "afw")
  route_table_name            = format("%s-%s", var.name_prefix, "rt")
  firewall_ip_configuration   = format("%s-%s", var.name_prefix, "ipconfig")
  application_rule_collection = format("%s-%s", var.name_prefix, "arc")
  network_rule_collection     = format("%s-%s", var.name_prefix, "nrc")
  nat_rule_collection         = format("%s-%s", var.name_prefix, "nrc-nat")

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

  nat_rules = {
    http = {
      port = "80"
    }
    https = {
      port = "443"
    }
  }
}
