terraform {

  required_version = ">= 1.2.8"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.50.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.36.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "1.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Configure the Azure Active Directory Provider
provider "azuread" { # default takes current user/identity tenant
}

provider "azapi" {
  # Configuration options
}
