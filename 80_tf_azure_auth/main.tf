provider "azurerm" {
  features {}

  subscription_id = "00000000000000-4a66-xxxx-4481e2f0517e"
  client_id       = "00000000000-2860-4349-b20b-da9ad1b9a450"
  client_secret   = "000000000000000.sJr.NRT212OLQfFBplG"
  tenant_id       = "00000000000000-4ef3-xxxx-ad55c555e729"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.56.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "spn_terraform_rg"
  location = "westeurope"
}

resource "azurerm_storage_account" "storage" {
  name                     = "terraform0spn1storage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}
