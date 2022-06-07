# reference to Azure Kubernetes Service AAD Server app in AAD
data "azuread_service_principal" "aks_aad_server" {
  display_name = "Azure Kubernetes Service AAD Server"
}

# current subscription
data "azurerm_subscription" "current" {}

# current client
data "azuread_client_config" "current" {}

# retrieve the versions of Kubernetes supported by AKS
data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
}