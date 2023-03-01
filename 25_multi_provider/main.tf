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
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "vnet_spoke" {
  provider            = azurerm.subscription_spoke
  name                = "vnet_spoke"
  resource_group_name = azurerm_resource_group.rg_spoke.name
  location            = "northeurope"
  address_space       = ["10.2.0.0/16"]
}

# The following peering will not work.
# Error: network.VirtualNetworkPeeringsClient#CreateOrUpdate: Failure sending request: StatusCode=403 
# -- Original Error: Code="LinkedAuthorizationFailed" 
# Message="The client has permission to perform action 'Microsoft.Network/virtualNetworks/peer/action' 
# on scope '/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg_hub/providers/Microsoft.Network/virtualNetworks/vnet_hub/virtualNetworkPeerings/hub_2_spoke', 
# however the current tenant '16b3c013-d300-468d-ac64-7eda0820b6d3' 
# is not authorized to access linked subscription '17b12858-3960-4e6f-a663-a06fdae23428'."
# resource "azurerm_virtual_network_peering" "hub_2_spoke" {
#   provider                     = azurerm.subscription_hub
#   name                         = "hub_2_spoke"
#   resource_group_name          = azurerm_resource_group.rg_hub.name
#   virtual_network_name         = azurerm_virtual_network.vnet_hub.name
#   remote_virtual_network_id    = azurerm_virtual_network.vnet_spoke.id
# }

# resource "azurerm_virtual_network_peering" "spoke_2_hub" {
#   provider                     = azurerm.subscription_spoke
#   name                         = "spoke_2_hub"
#   resource_group_name          = azurerm_resource_group.rg_spoke.name
#   virtual_network_name         = azurerm_virtual_network.vnet_spoke.name
#   remote_virtual_network_id    = azurerm_virtual_network.vnet_hub.id
# }