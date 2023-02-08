resource "azurerm_resource_group" "rg" {
  name     = "rg-vnet"
  location = "westeurope"
}

variable "vnets_count" {
  type    = list(string)
  default = ["vnet-c-2"] # ["vnet-c-1", "vnet-c-2"]
}

resource "azurerm_virtual_network" "vnet_count" {
  count               = length(var.vnets_count)
  name                = var.vnets_count[count.index]
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

variable "vnets_for_each" {
  type    = set(string)
  default = ["vnet-f-2"] # ["vnet-f-1", "vnet-f-2"]
}

resource "azurerm_virtual_network" "vnet_for_each" {
  for_each            = var.vnets_for_each
  name                = each.key
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
