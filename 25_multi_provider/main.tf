resource "azurerm_resource_group" "rg_hub" {
  provider = azurerm.subscription_hub
  name     = "rg_hub"
  location = "westeurope"
}

resource "azurerm_resource_group" "rg_spoke" {
  provider = azurerm.subscription_spoke
  name     = "rg_spoke"
  location = "northeurope"
}

resource "azurerm_virtual_network" "vnet_hub" {
  provider            = azurerm.subscription_hub
  name                = "vnet_hub"
  resource_group_name = azurerm_resource_group.rg_hub.name
  location            = "westeurope"
  address_space       = "10.1.0.0/16"
}

resource "azurerm_virtual_network" "vnet_spoke" {
  name                = "vnet_spoke"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.rg_spoke.name
  address_space       = "10.2.0.0/16"