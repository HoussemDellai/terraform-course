// provider "azurerm" {
//   version = "=2.39.0"
//   features {}
// }

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.39.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.0.0"
    }
  }
}
