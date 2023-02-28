resource "azurerm_resource_group" "rg" {
  name = "rg-vnet"
  location = "westeurope"
}

variable "vnets" {
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-spoke"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"] # ["10.0.0.0/8"]
}

# resource "azurerm_subnet" "subnet_01" {
#   name                 = "snet-01"
#   resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.1.0.0/16"]
# }

# resource "azurerm_subnet" "subnet_02" {
#   name                 = "snet-02"
#   resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.2.0.0/16"]
# }