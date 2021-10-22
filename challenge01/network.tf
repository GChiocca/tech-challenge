
resource "azurerm_virtual_network" "vnet" {
  address_space       = [var.vnet["address_space"]]
  location            = var.location
  name                = "vnet-${local.name}-01"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  for_each = var.vnet["subnets"]

  name                 = "snet-${each.key}-${local.name}-01"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value["subnet"]]
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-${local.name}-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = random_string.pip_dns_name.result
}

resource "azurerm_lb" "extlbweb" {
  name                = "lb-ext-web-${local.name}-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "pip-web-${local.name}-01"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_lb" "intlbapp" {
  name                = "lb-int-app-${local.name}-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "standard"
  frontend_ip_configuration {
    name                          = "lb-int-app-${local.name}-01"
    subnet_id                     = azurerm_subnet.subnet["app"].id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_lb" "intlbsql" {
  name                = "lb-int-sql-${local.name}-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "standard"
  frontend_ip_configuration {
    name                          = "lb-int-sql-${local.name}-01"
    subnet_id                     = azurerm_subnet.subnet["sql"].id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_traffic_manager_profile" "trfmgr_prf" {
  name                = "traf-${local.name}-01"
  resource_group_name = azurerm_resource_group.rg.name

  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = random_string.trfmgr_dns_name.result
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }
}

resource "azurerm_traffic_manager_endpoint" "trfmgr_enp" {
  name                = "traf-end-${local.name}-01"
  resource_group_name = azurerm_resource_group.rg.name
  profile_name        = azurerm_traffic_manager_profile.trfmgr_prf.name
  target_resource_id  = azurerm_public_ip.pip.id
  type                = "azureEndpoints"
  weight              = 100
}