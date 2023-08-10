terraform {

  required_version = ">= 1.2.8"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.68.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "1.8.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {}
