provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.46.1"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "westeurop"
}

resource "azurerm_storage_account" "storage" {
  name                     = "storage-demo"
  resource_group_name      = "stor*account" # error here
  location                 = "westeurop"
  account_tier             = "Standard"
  account_kind             = "StorageV3" # error here
  default_action           = "AllowAzure" # error here
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

resource "azurerm_managed_disk" "source" {
  encryption_settings {
      enabled = false
  }
}