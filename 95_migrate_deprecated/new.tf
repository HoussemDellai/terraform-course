resource "azurerm_resource_group" "rg" {
  name     = "MyResourceGroup"
  location = "westeurope"
}

# New supported resource type
resource "azurerm_service_plan" "plan" {
  name                = "MyAppServicePlan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "S1"
}

# New supported resource type
resource "azurerm_linux_web_app" "app" {
  name                = "mywebapp-01357"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.plan.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      dotnet_version = "6.0" # 3.1, 5.0, 6.0
    }
  }
}