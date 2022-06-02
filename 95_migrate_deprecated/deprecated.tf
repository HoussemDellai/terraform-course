# resource "azurerm_resource_group" "rg" {
#   name     = "MyResourceGroup"
#   location = "westeurope"
# }

# # Deprecated resource type
# resource "azurerm_app_service_plan" "plan" {
#   name                = "MyAppServicePlan"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   kind                = "Linux"
#   reserved            = true

#   sku {
#     tier = "Standard"
#     size = "S1"
#   }
# }

# # Deprecated resource type
# resource "azurerm_app_service" "app" {
#   name                = "mywebapp-01357"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   app_service_plan_id = azurerm_app_service_plan.plan.id

#   site_config {
#     dotnet_framework_version = "v4.0" # deprecated
#   }
# }