terraform {
  required_version = ">= 1.0.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.81.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}