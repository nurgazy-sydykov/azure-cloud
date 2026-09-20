resource "azurerm_subnet" "firewall" {
  name                 = local.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.firewall_subnet_address]
}

resource "azurerm_public_ip" "firewall" {
  name                = var.firewall_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "main" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = var.firewall_ip_configuration
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

resource "azurerm_route_table" "aks" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "${var.name_prefix}-default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = local.firewall_private_ip
  }
}

resource "azurerm_subnet_route_table_association" "aks" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.aks.id
}

resource "azurerm_firewall_application_rule_collection" "web" {
  name                = var.application_rule_collection
  azure_firewall_name = azurerm_firewall.main.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name             = "${var.name_prefix}-web-egress"
    source_addresses = ["10.0.0.0/16"]
    target_fqdns     = ["*"]

    dynamic "protocol" {
      for_each = local.application_protocols

      content {
        type = protocol.value.type
        port = protocol.value.port
      }
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "all_egress" {
  name                = var.network_rule_collection
  azure_firewall_name = azurerm_firewall.main.name
  resource_group_name = var.resource_group_name
  priority            = 200
  action              = "Allow"

  rule {
    name                  = "${var.name_prefix}-aks-egress"
    source_addresses      = ["10.0.0.0/16"]
    destination_addresses = ["*"]
    destination_ports     = ["*"]
    protocols             = local.network_protocols
  }
}

resource "azurerm_firewall_nat_rule_collection" "nginx" {
  name                = var.nat_rule_collection
  azure_firewall_name = azurerm_firewall.main.name
  resource_group_name = var.resource_group_name
  priority            = 300
  action              = "Dnat"

  rule {
    name                  = "${var.name_prefix}-nginx-http"
    source_addresses      = ["*"]
    destination_addresses = [local.firewall_public_ip]
    destination_ports     = ["80"]
    protocols             = ["TCP"]
    translated_address    = var.aks_loadbalancer_ip
    translated_port       = "80"
  }
}
