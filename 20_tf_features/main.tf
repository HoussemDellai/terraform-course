locals {
  # Common tags to be assigned to all resources
  common_tags = {
    CostCenter = var.cost_center_id
    Production = var.is_production
  }
}

resource "azurerm_resource_group" "global_rg" {
  name     = var.rg_name
  location = var.location

  tags = local.common_tags
}

resource "azurerm_resource_group" "env_rg" {
  for_each = {
    dev  = "eastus"
    test = "westus2"
    prod = "westeurope"
  }
  name     = each.key
  location = each.value
}
##############################################
resource "azurerm_resource_group" "apps_rg" {
  count    = 3
  name     = "app-${count.index}"
  location = "westeurope"
}
##############################################
variable "apps_names" {
  type    = list(string)
  default = ["frontend", "backend", "database"]
}

resource "azurerm_resource_group" "org_apps_rg" {
  count    = length(var.apps_names)
  name     = var.apps_names[count.index]
  location = "westeurope"
}