resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion-pip"
  location            = azurerm_resource_group.dns_rg.location
  resource_group_name = azurerm_resource_group.dns_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "linux_vm" {
  name                = "example-nic"
  location            = azurerm_resource_group.dns_rg.location
  resource_group_name = azurerm_resource_group.dns_rg.name

  ip_configuration {
    name                          = "linux-vm-ip"
    subnet_id                     = azurerm_subnet.bastion_sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "linux-vm"
  resource_group_name = azurerm_resource_group.dns_rg.name
  location            = azurerm_resource_group.dns_rg.location
  size                = var.vm_size
  disable_password_authentication = false
  admin_username      = "azureuser"
  admin_password      = "sadf8sa7asfas!"

  network_interface_ids = [
    azurerm_network_interface.linux_vm.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
