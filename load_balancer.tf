resource "azurerm_lb" "dns_lb" {
  name                = "dns-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.dns_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "ip-config"
    subnet_id                     = azurerm_subnet.dns_sn.id
    private_ip_address            = var.dns_lb_ip_address
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
  }
}

resource "azurerm_lb_backend_address_pool" "dnspool" {
  loadbalancer_id = azurerm_lb.dns_lb.id
  name            = "dns-address-pool"
}

resource "azurerm_lb_probe" "dns" {
  resource_group_name = azurerm_resource_group.dns_sn.name
  loadbalancer_id     = azurerm_lb.dns_lb.id
  name                = "dns-running-probe"
  port                = "53"
}

resource "azurerm_lb_rule" "dns_rule" {
  resource_group_name     = azurerm_resource_group.dns_rg.name
  loadbalancer_id         = azurerm_lb.dns_lb.id
  name                    = "dns"
  protocol                = "Udp"
  frontend_port           = "53"
  backend_port            = "53"
  backend_address_pool_id = azurerm_lb_backend_address_pool.dnspool.id
  probe_id                = azurerm_lb_probe.dns.id
}
