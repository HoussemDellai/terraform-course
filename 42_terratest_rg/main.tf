provider "azurerm" {
  version = "~> 2.20"
  features {}
}

terraform {
  required_version = ">= 0.12.26"
}

resource "azurerm_resource_group" "resource_group" {
  name     = "terratest-rg-${var.postfix}"
  location = var.location
}