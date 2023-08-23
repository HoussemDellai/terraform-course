data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
