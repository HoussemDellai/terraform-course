resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource azurerm_public_ip "pip" {
  name                = "pip-storage"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}