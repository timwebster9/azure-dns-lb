# VNET
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.0.0.0&mask=16&division=23.ff3100
resource "azurerm_virtual_network" "policy" {
  name                = "dns-vnet"
  location            = azurerm_resource_group.dns_rg.location
  resource_group_name = azurerm_resource_group.dns_rg.name
  address_space       = [var.vnet_address_space]
}

# SUBNETS
resource "azurerm_subnet" "bastion_sn" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.dns_rg.name
  virtual_network_name = azurerm_virtual_network.dns_rg.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

resource "azurerm_subnet" "dns_sn" {
  name                 = "dns-sn"
  resource_group_name  = azurerm_resource_group.dns_rg.name
  virtual_network_name = azurerm_virtual_network.dns_rg.name
  address_prefixes     = [var.dns_subnet_cidr]
}

