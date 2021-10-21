resource "azurerm_virtual_network" "vnet" {
  address_space       = var.vnet_address_space
  location            = var.location
  name                = "vnet-${local.name}-01"
  resource_group_name = azurerm_resource_group.rg.name
}
