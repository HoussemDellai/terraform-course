data "azurerm_subscription" "subscription" {
}

resource "azurerm_policy_assignment" "policy" {
  name                 = "deny-not-allowed-locations"
  scope                = data.azurerm_subscription.subscription.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  description          = "Policy Assignment for allowed Azure locations"
  display_name         = "Allowed Locations Policy Assignment"
  enforcement_mode     = true

  parameters = <<PARAMETERS
{
  "listOfAllowedLocations": {
    "value": [ "West Europe" ]
  }
}
PARAMETERS
}