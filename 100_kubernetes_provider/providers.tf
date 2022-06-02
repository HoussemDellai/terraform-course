provider "azurerm" {
  features {}
}

terraform {
  required_version = ">= 1.2.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.8.0"
    }
    azuread = {
      version = ">= 2.22.0"
    }
    kubernetes = {
      version = ">= 2.11.0"
    }
  }
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)

  # using kubelogin to get an AAD token for the cluster.
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args = [
      "get-token",
      "--environment",
      "AzurePublicCloud",
      "--server-id",
      "6dae42f8-4368-4678-94ff-3960e28e3630", # Note: The AAD server app ID of AKS Managed AAD is always 6dae42f8-4368-4678-94ff-3960e28e3630 in any environments.
      "--client-id",
      azuread_application.app.application_id, # SPN App Id created via terraform
      "--client-secret",
      azuread_service_principal_password.spn_password.value,
      "--tenant-id",
      data.azurerm_subscription.current.tenant_id, # AAD Tenant Id
      "--login",
      "spn"
    ]
  }
}