#------------------------------------------------------
# locals, lower
#------------------------------------------------------

locals {
  common_tags = {
    CostCenter = var.cost_center_id
    Production = var.is_production
  }
}

resource "azurerm_resource_group" "demo01_rg" {
  name     = lower(var.rg_name)
  location = var.location

  tags = local.common_tags
}

#------------------------------------------------------
# for_each
#------------------------------------------------------

resource "azurerm_resource_group" "demo02_rg" {
  for_each = {
    dev  = "eastus"
    test = "westus2"
    prod = "westeurope"
  }
  name     = each.key
  location = each.value
}

#------------------------------------------------------
# count
#------------------------------------------------------

resource "azurerm_resource_group" "demo03_rg" {
  count    = 3
  name     = "app-${count.index}"
  location = "westeurope"
}

#------------------------------------------------------
# count, list
#------------------------------------------------------

variable "apps_names" {
  type    = list(string)
  default = ["frontend", "backend", "database"]
}

resource "azurerm_resource_group" "demo04_rg" {
  count    = length(var.apps_names)
  name     = var.apps_names[count.index]
  location = "westeurope"
}

#------------------------------------------------------
# if, else
#------------------------------------------------------

resource "azurerm_resource_group" "demo05_rg" {
  name     = "dev-rg"
  location = var.location != "" ? var.location : "westeurope"
}

# managed_disk_type = var.environment == "Dev" ? "Standard_LRS" : "Premium_LRS"

#------------------------------------------------------
# random_string
#------------------------------------------------------

resource "random_string" "demo06_random_password" {
  length           = 20
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
  min_special      = 2
  min_upper        = 2
  min_lower        = 5
  min_numeric      = 3
}

output "demo06_random_password" {
  value = random_string.demo06_random_password.result
}

#------------------------------------------------------
# random_integer
#------------------------------------------------------

resource "random_integer" "demo07_random_number" {
  min = 5
  max = 100
}

output "demo07_random_number" {
  value = random_integer.demo07_random_number.result
}

#------------------------------------------------------
# random_uuid
#------------------------------------------------------

resource "random_uuid" "demo08_random_id" {}

output "demo08_random_id" {
  value = random_uuid.demo08_random_id.result
}