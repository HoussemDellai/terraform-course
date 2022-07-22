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

#------------------------------------------------------
# dynamic
#------------------------------------------------------

# https://www.terraform.io/language/expressions/dynamic-blocks

resource "azurerm_resource_group" "demo07_rg" {
  name     = "demo07_rg"
  location = "West Europe"
}

locals {
  subnets = [{
    subnet_name           = "subnet1"
    subnet_address_prefix = "10.0.1.0/24"
    },
    {
      subnet_name           = "subnet2"
      subnet_address_prefix = "10.0.2.0/24"
    },
    {
      subnet_name           = "subnet3"
      subnet_address_prefix = "10.0.3.0/24"
  }]
}
resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  location            = azurerm_resource_group.demo07_rg.location
  resource_group_name = azurerm_resource_group.demo07_rg.name
  address_space       = ["10.0.0.0/16"]

  dynamic "subnet" {
    for_each = local.subnets
    content {
      name           = subnet.value.subnet_name
      address_prefix = subnet.value.subnet_address_prefix
    }
  }
  # subnet {
  #   name           = "subnet1"
  #   address_prefix = "10.0.1.0/24"
  # }
  # subnet {
  #   name           = "subnet2"
  #   address_prefix = "10.0.2.0/24"
  # }
}

resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.demo07_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#------------------------------------------------------
# enable or disable resources
#------------------------------------------------------

variable "resource_enabled" {
  type        = bool
  default     = true # false # 
  description = "Enable or disable creation of Resource Group"
}

# resource "azurerm_resource_group" "rg_tf_enabled_resource" {
#   enabled  = var.resource_enabled # this attribute doesn't exist
#   name     = "rg_tf_enabled_resource"
#   location = "westeurope"
# }

resource "azurerm_resource_group" "rg_tf_enabled_resource_for_each" {
  for_each = var.resource_enabled ? toset(["any_value"]) : toset([])
  name     = "rg_tf_enabled_resource"
  location = "westeurope"
}

output "rg_id_for_each" {
  value = var.resource_enabled ? azurerm_resource_group.rg_tf_enabled_resource_for_each["any_value"].id : null
}

resource "azurerm_resource_group" "rg_tf_enabled_resource_count" {
  count    = var.resource_enabled ? 1 : 0
  name     = "rg_tf_enabled_resource"
  location = "westeurope"
}

output "rg_id_count" {
  value = var.resource_enabled ? azurerm_resource_group.rg_tf_enabled_resource_count.0.id : null
}

#------------------------------------------------------
# enable or disable nested blocks
#------------------------------------------------------

resource "azurerm_storage_account" "storage_tf_enabled_resource_for_inner_block" {
  name                     = "storage091"
  resource_group_name      = azurerm_resource_group.rg_tf_enabled_resource_for_each["any_value"].name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  dynamic "network_rules" {
    for_each = var.resource_enabled ? ["any_value"] : []
    # count = var.resource_enabled ? 1 : 0 # count couldn't be used inside nested block
    content {
      default_action             = "Deny"
      ip_rules                   = ["100.0.0.1"]
    }
  }
}