resource "azurerm_resource_group" "rg" {
  name     = "rg-prod"
  location = "westeurope"
}

module "keyvault" {
  source = "./modules/keyvault"

  key_vault_name      = "kv123579"
  resource_group_name = azurerm_resource_group.rg.name
}

# Scenario 1: module storage_account does not depend on module keyvault

# module "storage_account" {
#   source = "./modules/storage_account"

#   storage_account_name = "strg1235790"
#   resource_group_name  = azurerm_resource_group.rg.name
# }

# Scenario 2: module storage_account depends explicitly on module keyvault

# module "storage_account" {
#   source = "./modules/storage_account"

#   storage_account_name = "strg1235790"
#   resource_group_name  = azurerm_resource_group.rg.name

#   depends_on = [ module.keyvault ] # explicit dependency on entire module
# }

# Scenario 3: module storage_account depends implicitly on module keyvault
# Depends only on the public IP from module keyvault

module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name = module.keyvault.key_vault_name # implicit dependency on key_vault_name output
  resource_group_name  = azurerm_resource_group.rg.name
}