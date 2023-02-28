terraform {
  required_version = ">= 1.2.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.43.0"
    }

    # azuread = {
    #   source  = "hashicorp/azuread"
    #   version = ">= 2.29.0"
    # }
  }
}

provider "azurerm" {
  alias           = "subscription_hub"
  subscription_id = "82f6d75e-85f4-434a-ab74-5dddd9fa8910"
  tenant_id       = "16b3c013-d300-468d-ac64-7eda0820b6d3"
  # client_id       = "a0d7fbe0-dca2-4848-b6ac-ad15e2c31840"
  # client_secret   = "BAFHTR3235FEHsdfb%#$W%weF#@a"
  # auxiliary_tenant_ids = ["558506eb-9459-4ef3-b920-ad55c555e729"]
  features {}
}

provider "azurerm" {
  alias           = "subscription_spoke"
  subscription_id = "17b12858-3960-4e6f-a663-a06fdae23428"
  tenant_id       = "558506eb-9459-4ef3-b920-ad55c555e729"
  # client_id       = "a0d7fbe0-xxxxxxxxxxxxxxxxxxxxx"
  # client_secret   = "BAFHTxxxxxxxxxxxxxxxxxxxxxxxxx"
  # auxiliary_tenant_ids = ["72f988bf-86f1-41af-91ab-2d7cd011db47"] # (Optional) List of auxiliary Tenant IDs required for multi-tenancy and cross-tenant scenarios. This can also be sourced from the ARM_AUXILIARY_TENANT_IDS Environment Variable.
  features {}
}

# Configure the Azure Active Directory Provider
# provider "azuread" { # default takes current user/identity tenant
# }

# provider "azuread" {
#   alias     = "tenant_hub"
#   tenant_id = "72f988bf-86f1-41af-91ab-2d7cd011db47"
#   # use_cli = true
# }

# provider "azuread" {
#   alias     = "tenant_spoke"
#   tenant_id = "558506eb-9459-4ef3-b920-ad55c555e729"
#   # use_cli = true
# }