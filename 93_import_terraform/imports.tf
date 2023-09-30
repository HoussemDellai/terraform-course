import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform"
    to = azurerm_resource_group.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.KeyVault/vaults/kv12357913tf01"
    to = azurerm_key_vault.main
}

import {
    id = "https://kv12357913tf.vault.azure.net/secrets/terraform-backend-key/1ddace06fdbe4400a357474255564a2e  "
    to = azurerm_key_vault_secret.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Compute/virtualMachines/vm-terraform"
    to = azurerm_virtual_machine.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Web/serverfarms/asp-terraform"
    to = azurerm_app_service_plan.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Web/sites/webapp-terraform"
    to = azurerm_app_service.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.App/managedEnvironments/containerapp-terraform"
    to = azurerm_container_app_environment.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.App/containerApps/containerapp-terraform"
    to = azurerm_container_app.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.ContainerService/managedClusters/aks-terraform"
    to = azurerm_kubernetes_cluster.main
}

import {
    id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.ContainerService/managedClusters/aks-terraform/agentPools/npapps"
    to = azurerm_kubernetes_cluster_node_pool.main
}
