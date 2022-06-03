# current subscription
data "azurerm_subscription" "current" {}

# current client
data "azuread_client_config" "current" {}

# retrieve the versions of Kubernetes supported by AKS
data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
}