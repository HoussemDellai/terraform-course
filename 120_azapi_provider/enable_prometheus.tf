resource "null_resource" "enable_azuremonitormetrics" {
  # for windows
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command     = <<-EOT

      az aks update --enable-azuremonitormetrics `
                    -g ${azurerm_kubernetes_cluster.aks.resource_group_name} `
                    -n ${azurerm_kubernetes_cluster.aks.name} `
                    --azure-monitor-workspace-resource-id ${azapi_resource.prometheus.id}
    EOT
  }

  triggers = {
    "key" = "value1"
  }

  # for linux
  # provisioner "local-exec" {
  #   command    = "az aks update --enable-azuremonitormetrics -g ${azurerm_kubernetes_cluster.aks.resource_group_name} -n ${azurerm_kubernetes_cluster.aks.name} --azure-monitor-workspace-resource-id ${azapi_resource.prometheus.id}"
  # }
}
