##############################################
# locals, lower
##############################################

locals {
  common_tags = {
    CostCenter = var.cost_center_id
    Production = var.is_production
  }
}

resource "azurerm_resource_group" "global_rg" {
  name     = lower(var.rg_name)
  location = var.location

  tags = local.common_tags
}

##############################################
# for_each
##############################################

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
# count
##############################################

resource "azurerm_resource_group" "apps_rg" {
  count    = 3
  name     = "app-${count.index}"
  location = "westeurope"
}

##############################################
# count, list
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

##############################################
# if, else
##############################################

resource "azurerm_resource_group" "dev_rg" {
  name                  = "dev-rg"
  location              = var.location != "" ? var.location : "westeurope"
}

# managed_disk_type = var.environment == "Dev" ? "Standard_LRS" : "Premium_LRS"