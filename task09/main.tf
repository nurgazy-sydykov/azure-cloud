data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = data.azurerm_resource_group.existing.name
}

module "afw" {
  source = "./modules/afw"

  location                    = var.location
  resource_group_name         = data.azurerm_resource_group.existing.name
  virtual_network_name        = data.azurerm_virtual_network.existing.name
  aks_subnet_id               = data.azurerm_subnet.aks.id
  firewall_subnet_address     = "10.0.1.0/26"
  name_prefix                 = local.name_prefix
  firewall_public_ip_name     = "${local.name_prefix}-pip"
  firewall_name               = "${local.name_prefix}-afw"
  route_table_name            = "${local.name_prefix}-rt"
  firewall_ip_configuration   = "${local.name_prefix}-ipconfig"
  application_rule_collection = "${local.name_prefix}-arc"
  network_rule_collection     = "${local.name_prefix}-nrc"
  nat_rule_collection         = "${local.name_prefix}-nrc-nat"
  aks_loadbalancer_ip         = var.aks_loadbalancer_ip
}
