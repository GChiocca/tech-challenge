data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vm" {
  name                     = "kv-${local.name}-01"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "random_password" "vm" {
  length      = 30
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  min_special = 1
}

resource "azurerm_key_vault_secret" "vm" {
  name         = local.vm_secret
  key_vault_id = azurerm_key_vault.vm.id
  value        = random_password.vm.result
}
