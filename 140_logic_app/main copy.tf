# resource "azurerm_resource_group" "rg" {
#   name     = "rg-logic-app-demo"
#   location = "westeurope"
# }

# resource "azurerm_logic_app_workflow" "logic_app_email_sender" {
#   count               = 0
#   name                = "logic-app-demo-1357913"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name

#   workflow_parameters = {
#     "$connections" = jsonencode({
#       type : "Object"
#     })
#   }
#   parameters = {
#     "$connections" = jsonencode({
#       outlook = {
#         connectionId   = "${azurerm_api_connection.api_connection_outlook.id}"
#         connectionName = "outlook"
#         id             = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/providers/Microsoft.Web/locations/westeurope/managedApis/outlook"
#       }
#     })
#   }
#   #   parameters = {
#   #     "connections" = <<CONNECTIONS
#   #     "value": {
#   #       "outlook": {
#   #           "connectionId": "${azurerm_api_connection.api_connection_outlook.id}",
#   #           "connectionName": "outlook",
#   #           "id": "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/providers/Microsoft.Web/locations/westeurope/managedApis/outlook"
#   #       }
#   #     }
#   #     CONNECTIONS
#   #   }
#   #   workflow_parameters = {
#   #     connections = jsonencode({
#   #       value: {
#   #         outlook: {}
#   #       }
#   #     })
#   #   }
#   #   workflow_parameters = {
#   #     connections = <<CONNECTIONS
#   #       "value": {
#   #           "outlook": {
#   #               "connectionId": "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-logic-app-demo/providers/Microsoft.Web/connections/outlook"
#   #           }
#   #       }
#   #     CONNECTIONS
#   #     #     "value": {
#   #     #         "outlook": {
#   #     #             "connectionId": "${azurerm_api_connection.api_connection_outlook.id}",
#   #     #             "connectionName": "${azurerm_api_connection.api_connection_outlook.name}",
#   #     #             "id": "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/providers/Microsoft.Web/locations/westeurope/managedApis/outlook"
#   #     #         }
#   #     #     }
#   #     # CONNECTIONS
#   #   }
# }

# resource "azurerm_logic_app_trigger_http_request" "logic_app_trigger_http" {
#   count        = 0
#   name         = "http-trigger"
#   logic_app_id = azurerm_logic_app_workflow.logic_app_email_sender.id
#   #   method       = "POST"

#   schema = <<SCHEMA
# {
#     "type": "object",
#     "properties": {
#         "email": {
#             "type": "string"
#         },
#         "sas_url": {
#             "type": "string"
#         }
#     }
# }
# SCHEMA

# }

# resource "azurerm_logic_app_action_custom" "action_send_email" {
#   count        = 0
#   name         = "action-send-email"
#   logic_app_id = azurerm_logic_app_workflow.logic_app_email_sender.id

#   body = <<BODY
# {
#     "runAfter": {},
#     "type": "ApiConnection",
#     "inputs": {
#         "host": {
#             "connection": {
#                 "name": "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-logic-app-demo/providers/Microsoft.Web/connections/outlook"
#             }
#         },
#         "method": "post",
#         "body": {
#             "To": "houssem.dellai@live.com",
#             "Subject": "hello",
#             "Body": "<p>Hello,</p><br><p>We are happy to tell you your video file is now available to download on this link: </p><br><p>Thank you,</p>",
#             "Importance": "Normal"
#         },
#         "path": "/v2/Mail"
#     }
# }
# BODY

# }

# data "azurerm_managed_api" "managed_api_outlook" {
#   name     = "outlook"
#   location = azurerm_resource_group.rg.location
# }

# resource "azurerm_api_connection" "api_connection_outlook" {
#   name                = "outlook"
#   resource_group_name = azurerm_resource_group.rg.name
#   managed_api_id      = data.azurerm_managed_api.managed_api_outlook.id
#   display_name        = "outlook"

#   #   parameter_values = {
#   #     connectionString = azurerm_servicebus_namespace.example.default_primary_connection_string
#   #   }

#   #   lifecycle {
#   #     # NOTE: since the connectionString is a secure value it's not returned from the API
#   #     ignore_changes = ["parameter_values"]
#   #   }
# }
