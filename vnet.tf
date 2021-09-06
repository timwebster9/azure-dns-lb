# VNET
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.0.0.0&mask=16&division=23.ff3100
resource "azurerm_virtual_network" "dns" {
  name                = "dns-vnet"
  location            = azurerm_resource_group.dns_rg.location
  resource_group_name = azurerm_resource_group.dns_rg.name
  address_space       = [var.vnet_address_space]
}

# SUBNETS
resource "azurerm_subnet" "bastion_sn" {
  name                 = "bastion-sn"
  resource_group_name  = azurerm_resource_group.dns_rg.name
  virtual_network_name = azurerm_virtual_network.dns.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

resource "azurerm_subnet" "dns_sn" {
  name                 = "dns-sn"
  resource_group_name  = azurerm_resource_group.dns_rg.name
  virtual_network_name = azurerm_virtual_network.dns.name
  address_prefixes     = [var.dns_subnet_cidr]
}

resource "azurerm_network_security_group" "bastion" {
  name                = "bastion-nsg"
  location            = azurerm_resource_group.dns_rg.location
  resource_group_name = azurerm_resource_group.dns_rg.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "212.159.71.60"
    destination_address_prefix = "*"
  }
}

resource azurerm_subnet_network_security_group_association "bastion-nsg-assoc" {
  subnet_id                 = azurerm_subnet.dns_sn.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}
