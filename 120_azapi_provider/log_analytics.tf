resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "log-analytics-workspace"
  resource_group_name = azurerm_resource_group.rg_monitoring.name
  location            = var.resources_location
  sku                 = "PerGB2018" # PerGB2018, Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation
  retention_in_days   = 30          # possible values are either 7 (Free Tier only) or range between 30 and 730
}

resource "azurerm_log_analytics_solution" "solution" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.workspace.location
  resource_group_name   = azurerm_log_analytics_workspace.workspace.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.workspace.id
  workspace_name        = azurerm_log_analytics_workspace.workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}