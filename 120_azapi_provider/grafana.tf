resource "azurerm_dashboard_grafana" "grafana" {
  name                              = var.grafana_name
  resource_group_name               = azurerm_resource_group.rg_monitoring.name
  location                          = azurerm_resource_group.rg_monitoring.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = true
  sku                               = "Standard"
  zone_redundancy_enabled           = true

  azure_monitor_workspace_integrations {
    resource_id = azapi_resource.prometheus.id
  }

  identity {
    type = "SystemAssigned" # The only possible values is SystemAssigned
  }
}

data "azurerm_client_config" "current" {}

# assign current user as Grafana Admin
resource "azurerm_role_assignment" "role_grafana_admin" {
  scope                = azurerm_dashboard_grafana.grafana.id
  role_definition_name = "Grafana Admin"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "role_monitoring_data_reader" {
  scope                = azapi_resource.prometheus.id
  role_definition_name = "Monitoring Data Reader"
  principal_id         = azurerm_dashboard_grafana.grafana.identity.0.principal_id
}

data "azurerm_subscription" "current" {}

# https://learn.microsoft.com/en-us/azure/azure-monitor/visualize/grafana-plugin
# (Optional) Grafana to monitor all Azure resources
resource "azurerm_role_assignment" "role_monitoring_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.grafana.identity.0.principal_id
}

output "garafana_endpoint" {
  value = azurerm_dashboard_grafana.grafana.endpoint
}