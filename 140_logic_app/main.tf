resource "azurerm_resource_group" "rg" {
  name     = "rg-logic-app-demo"
  location = "westeurope"
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

  template_content = <<TEMPLATE
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "workflows_logic_app_name": {
            "type": "String"
        },
        "connections_outlook_externalid": {
            "type": "String"
        },
        "connections_outlook_id": {
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "type": "Microsoft.Logic/workflows",
            "apiVersion": "2017-07-01",
            "name": "[parameters('workflows_logic_app_name')]",
            "location": "westeurope",
            "properties": {
                "state": "Enabled",
                "definition": {
                    "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
                    "contentVersion": "1.0.0.0",
                    "parameters": {
                        "$connections": {
                            "defaultValue": {},
                            "type": "Object"
                        }
                    },
                    "triggers": {
                        "http-trigger": {
                            "type": "Request",
                            "kind": "Http",
                            "inputs": {
                                "schema": {
                                    "properties": {
                                        "email": {
                                            "type": "string"
                                        },
                                        "sas_url": {
                                            "type": "string"
                                        }
                                    },
                                    "type": "object"
                                }
                            }
                        }
                    },
                    "actions": {
                        "action-send-email": {
                            "runAfter": {},
                            "type": "ApiConnection",
                            "inputs": {
                                "body": {
                                    "Body": "<p>Hello,</p><br><p>We are happy to tell you your video file is now available to download on this link: @{triggerBody()?['sas_url']}</p><br><p>Thank you,</p>",
                                    "Importance": "Normal",
                                    "Subject": "hello",
                                    "To": "@triggerBody()?['email']"
                                },
                                "host": {
                                    "connection": {
                                        "name": "@parameters('$connections')['outlook']['connectionId']"
                                    }
                                },
                                "method": "post",
                                "path": "/v2/Mail"
                            }
                        }
                    }
                },
                "parameters": {
                    "$connections": {
                        "value": {
                            "outlook": {
                                "connectionId": "[parameters('connections_outlook_externalid')]",
                                "connectionName": "outlook",
                                "id": "[parameters('connections_outlook_id')]"
                            }
                        }
                    }
                }
            }
        }
    ]
}
TEMPLATE
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
