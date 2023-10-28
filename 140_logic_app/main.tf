resource "azurerm_resource_group" "rg" {
  name     = "rg-logic-app-demo"
  location = "westeurope"
}

data "azurerm_managed_api" "managed_api_outlook" {
  name     = "outlook"
  location = azurerm_resource_group.rg.location
}

resource "azurerm_api_connection" "api_connection_outlook" {
  name                = "outlook"
  resource_group_name = azurerm_resource_group.rg.name
  managed_api_id      = data.azurerm_managed_api.managed_api_outlook.id
  display_name        = "outlook"
}

resource "azurerm_resource_group_template_deployment" "logic_app" {
  name                = "logic-app-deploy"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental" # "Complete" # 

  parameters_content = jsonencode({
    workflows_logic_app_name       = { value = "logic-app-demo-135791555" }
    connections_outlook_externalid = { value = azurerm_api_connection.api_connection_outlook.id }
    connections_outlook_id         = { value = data.azurerm_managed_api.managed_api_outlook.id }
  })

  template_content = file("logicapp.json")
}