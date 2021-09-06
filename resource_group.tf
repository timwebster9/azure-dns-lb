# RG
resource "azurerm_resource_group" "dns_rg" {
  name     = "dns-lb-rg"
  location = var.location
}