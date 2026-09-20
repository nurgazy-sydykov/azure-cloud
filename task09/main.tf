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

  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.existing.name
  virtual_network_name          = data.azurerm_virtual_network.existing.name
  aks_subnet_id                 = data.azurerm_subnet.aks.id
  virtual_network_address_space = var.virtual_network_address_space
  name_prefix                   = local.name_prefix
  aks_loadbalancer_ip           = var.aks_loadbalancer_ip
}
