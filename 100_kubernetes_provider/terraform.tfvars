resource_group_name  = "rg_aks_terraform"
location             = "westeurope"
cluster_name         = "aks-cluster"
kubernetes_version   = "1.23.5"
system_node_count    = 2
spn_name             = "spn-aks-tf-dev"
kube_namespace       = "frontend-app-namespace"
aad_group_aks_admins = "group_aks_tf_admins"