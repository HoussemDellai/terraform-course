# resource group in Azure
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup2"
  location = "westeurope"
}