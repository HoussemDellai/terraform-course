# resource group in Azure
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup2"
  location = "westeurope"
}

# storage account in Azure
resource "azurerm_storage_account" "storage" {
  name                     = "tfsademo01" # replace with unique name
  resource_group_name      = "myResourceGroup"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}