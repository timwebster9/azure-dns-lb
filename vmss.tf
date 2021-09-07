resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {
  name                = "dns-vm"
  resource_group_name = azurerm_resource_group.dns_rg.name
  location            = azurerm_resource_group.dns_rg.location
  sku                 = "Standard_D2s_v3"
  instances           = 2
  upgrade_mode        = "Rolling"
  zone_balance        = true
  disable_password_authentication = false
  admin_username      = "azureuser"
  admin_password      = "sadf8sa7asfas!"

  #health_probe_id = azurerm_lb_probe.dns.id

  depends_on = [
      azurerm_lb_rule.dns_rule
  ]

  network_interface {
    name    = "linux-vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.dns_sn.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.dnspool.id]
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = var.vm_image_id
}