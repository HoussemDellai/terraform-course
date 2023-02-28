locals {
  resource_types = toset([
    "Microsoft.Network/networkSecurityGroups",
    "Microsoft.Network/virtualNetworks",
    "Microsoft.Network/applicationGateways",
    "Microsoft.Network/bastionHosts",
    "Microsoft.Network/networkInterfaces",
    "Microsoft.Compute/virtualMachines",
    "Microsoft.KeyVault/vaults",
    "Microsoft.Network/azureFirewalls",
    "Microsoft.Storage/storageAccounts",
    "Microsoft.ContainerRegistry/registries",
    "Microsoft.ContainerService/managedClusters",
    "Microsoft.Network/publicIPAddresses"
  ])
}

data azurerm_resources resources_ds {
  for_each = local.resource_types
  type     = each.key
}

locals {
    resources = flatten([ 
      for rt in data.azurerm_resources.resources_ds : [
        for r in rt.resources :
          r 
          if length(r.tags) > 0 
          && contains(r.tags, "ms-resource-usage")
        #   && r.tags["ms-resource-usage"] == "azure-cloud-shell"
        #   if r.tags["environment"] == var.environment
      ]
    ])

  resource_ids = flatten([for r in data.azurerm_resources.resources_ds : [r.resources.*.id]])
}

output resources_id {
  value = local.resource_ids
}

output resources {
  value = local.resources
}
