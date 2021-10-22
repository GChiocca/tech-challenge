resource "azurerm_resource_group" "rg" {
  #name     = "rg-${local.name}-01"
  name     = "uks-ut-syn2tr-01-rg"
  location = var.location
}

resource "random_string" "pip_dns_name" {
  length      = 12
  special = false
  lower = true
  upper = false
}

resource "random_string" "trfmgr_dns_name" {
  length      = 12
  special = false
  lower = true
  upper = false
}