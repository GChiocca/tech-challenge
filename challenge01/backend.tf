terraform {
  backend "azurerm" {
    resource_group_name  = "rg-clngtf-dev-uks-01"
    storage_account_name = "stchallenge01tf001"
    container_name       = "state"
    key                  = "clng.terraform.tfstate"
  }
}
