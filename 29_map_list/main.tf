variable "cidr" {
  #   type = map
  default = {
    "prod" = ["10.7.3.0/24", "10.7.4.0/24"]
    "test" = ["10.8.3.0/24", "10.8.4.0/24"]
  }
}

output "prod_cidr" {
  value = var.cidr["prod"]
}

variable "subnets" {
  default = {
    "AzureFirewallSubnet" = {
      "address_prefixes" = [
        "10.0.0.64/26",
      ]
      "delegation"                                     = []
      "enforce_private_link_endpoint_network_policies" = false
      "enforce_private_link_service_network_policies"  = false
      "id"                                             = "/subscriptions/xxxxxxxxxxxxxxxxx-5dddd9fa8910/resourceGroups/rg-lzaaca-hub-dev-neu/providers/Microsoft.Network/virtualNetworks/vnet-dev-neu-hub/subnets/AzureFirewallSubnet"
      "name"                                           = "AzureFirewallSubnet"
      "private_endpoint_network_policies_enabled"      = true
      "private_link_service_network_policies_enabled"  = true
      "resource_group_name"                            = "rg-lzaaca-hub-dev-neu"
      "service_endpoint_policy_ids"                    = []
      "service_endpoints"                              = []
      "timeouts"                                       = null /* object */
      "virtual_network_name"                           = "vnet-dev-neu-hub"
    }
    "GatewaySubnet" = {
      "address_prefixes" = [
        "10.0.0.0/27",
      ]
      "delegation"                                     = []
      "enforce_private_link_endpoint_network_policies" = false
      "enforce_private_link_service_network_policies"  = false
      "id"                                             = "/subscriptions/xxxxxxxxxxxxxxxxx-5dddd9fa8910/resourceGroups/rg-lzaaca-hub-dev-neu/providers/Microsoft.Network/virtualNetworks/vnet-dev-neu-hub/subnets/GatewaySubnet"
      "name"                                           = "GatewaySubnet"
      "private_endpoint_network_policies_enabled"      = true
      "private_link_service_network_policies_enabled"  = true
      "resource_group_name"                            = "rg-lzaaca-hub-dev-neu"
      "service_endpoint_policy_ids"                    = []
      "service_endpoints"                              = []
      "timeouts"                                       = null /* object */
      "virtual_network_name"                           = "vnet-dev-neu-hub"
    }
  }
}

output "subnetFirewall" {
  value = var.subnets["AzureFirewallSubnet"]
}

output "subnetFirewallId" {
  value = var.subnets["AzureFirewallSubnet"].id
}

variable "subnets-1-2" {
  default = [
    {
      name            = "subnet-1"
      addressPrefixes = ["10.0.1.0/24"]
    },
    {
      name            = "subnet-2"
      addressPrefixes = ["10.0.2.0/24"]
    }
  ]
}

variable "subnets-3-4" {
  default = [
    {
      name            = "subnet-3"
      addressPrefixes = ["10.0.3.0/24"]
      service_delegation = [{
        name    = "Microsoft.App/environments"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }]
    },
    {
      name            = "subnet-4"
      addressPrefixes = ["10.0.4.0/24"]
    }
  ]
}

variable "subnet-5" {
  default = {
    name            = "subnet-5"
    addressPrefixes = ["10.0.5.0/24"]
  }
}

output "subnetsConcat" {
  value = concat(var.subnets-1-2, var.subnets-3-4, [var.subnet-5])
}

output "subnetsFlatten" {
  value = flatten([var.subnets-1-2, var.subnets-3-4, [var.subnet-5]])
}

# output "subnetMerge" {
#   value = merge(var.subnets-1-2, var.subnets-3-4, [var.subnet-5])
# }

output "subnetsConditional" {
  value = "true" != "true" ? concat(var.subnets-1-2, [
    {
      name            = "subnet-6"
      addressPrefixes = ["10.0.6.0/24"]
    },
    {
      name            = "subnet-7"
      addressPrefixes = ["10.0.7.0/24"]
      # other           = "other"
    }
  ]) : var.subnets-1-2
}

output "concat_with_null" {
 value = concat(var.subnets-1-2, [null])
}