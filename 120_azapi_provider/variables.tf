variable "resources_location" {
  type    = string
  default = "westeurope"
}

variable "rg_aks_cluster" {
  type    = string
  default = "rg-aks-cluster"
}

variable "rg_monitoring" {
  type    = string
  default = "rg-monitoring"
}

variable "aks_name" {
  type    = string
  default = "aks-cluster"
}

variable "grafana_name" {
  type    = string
  default = "azure-grafana-13579"
}

variable "prometheus_name" {
  type    = string
  default = "azure-prometheus"
}
