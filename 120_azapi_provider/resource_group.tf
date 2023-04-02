resource "azurerm_resource_group" "rg_aks_cluster" {
  name     = var.rg_aks_cluster
  location = var.resources_location
}

resource "azurerm_resource_group" "rg_monitoring" {
  name     = var.rg_monitoring
  location = var.resources_location
}