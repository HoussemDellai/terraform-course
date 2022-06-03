variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}

variable "spn_name" {
  type        = string
  description = "Name of Service Principal"
}

variable "kube_namespace" {
  type        = string
  description = "Name of Kubernetes Namespace"
}

variable "aad_group_aks_admins" {
  type        = string
  description = "Name of AAD group for AKS admins"
}