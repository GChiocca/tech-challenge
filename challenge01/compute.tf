resource "azurerm_availability_set" "av_set" {
  count                       = 3
  name                        = "avail-${local.name}-0${count.index + 1}"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  platform_fault_domain_count = 2
}

# web vms
resource "azurerm_network_interface" "web_nic" {
  count               = var.vm_web["count"]
  name                = "nic-${local.name}-web-0${count.index + 1}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "nic-${local.name}-web-0${count.index + 1}-ip-config"
    subnet_id                     = azurerm_subnet.subnet["web"].id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "web_vm" {
  count               = var.vm_web["count"]
  name                = "vm-${local.name}-web-0${count.index + 1}"
  computer_name       = "${local.vm_name_prefix}web0${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  availability_set_id = azurerm_availability_set.av_set[0].id
  location            = var.location
  size                = var.vm_web["size"]
  admin_username      = local.vm_local_admin
  admin_password      = azurerm_key_vault_secret.vm.value
  network_interface_ids = [
    azurerm_network_interface.web_nic[count.index].id,
  ]

  os_disk {
    name                 = "${local.vm_name_prefix}web0${count.index + 1}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

# app vms
resource "azurerm_network_interface" "app_nic" {
  count               = var.vm_app["count"]
  name                = "nic-${local.name}-app-0${count.index + 1}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "nic-${local.name}-app-0${count.index + 1}-ip-config"
    subnet_id                     = azurerm_subnet.subnet["app"].id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "app_vm" {
  count               = var.vm_app["count"]
  name                = "vm-${local.name}-app-0${count.index + 1}"
  computer_name       = "${local.vm_name_prefix}app0${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg.name
  availability_set_id = azurerm_availability_set.av_set[1].id
  location            = var.location
  size                = var.vm_app["size"]
  admin_username      = local.vm_local_admin
  admin_password      = azurerm_key_vault_secret.vm.value
  network_interface_ids = [
    azurerm_network_interface.app_nic[count.index].id,
  ]

  os_disk {
    name                 = "${local.vm_name_prefix}app0${count.index + 1}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
# sql vms omitted for brevity