# old syntax
# provider "azurerm" {
#   version = "=2.40.0"
#   features {}
# }

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.11.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
  }
}
