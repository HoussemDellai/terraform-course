resource "azurerm_resource_group" "rg" {
  name     = "my-resources"
  location = "West Europe"
}

module "vnet" {
  source              = "./modules/vnet"
  # source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  subnet_names        = ["subnet1","subnet2","subnet3"]

  depends_on = [azurerm_resource_group.rg]
}