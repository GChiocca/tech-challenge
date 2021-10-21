resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.name}-01"
  location = var.location
}