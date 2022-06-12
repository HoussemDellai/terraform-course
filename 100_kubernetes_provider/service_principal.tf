resource "azuread_application" "app" {
  display_name = var.spn_name
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal
resource "azuread_service_principal" "spn" {
  application_id = azuread_application.app.application_id
}

resource "azuread_service_principal_password" "spn_password" {
  service_principal_id = azuread_service_principal.spn.id
}

resource "azuread_group" "aks_admins" {
  display_name     = var.aad_group_aks_admins
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]

  members = [
    data.azuread_client_config.current.object_id,
    azuread_service_principal.spn.object_id,
  ]
}