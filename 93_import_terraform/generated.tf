# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform"
resource "azurerm_resource_group" "main" {
  location   = "westeurope"
  managed_by = null
  name       = "rg-terraform"
  tags       = {}
}

# __generated__ by Terraform
resource "azurerm_container_app_environment" "main" {
  dapr_application_insights_connection_string = null # sensitive
  infrastructure_subnet_id                    = null
  internal_load_balancer_enabled              = false
  location                                    = "westeurope"
  log_analytics_workspace_id                  = null
  name                                        = "containerapp-terraform"
  resource_group_name                         = "rg-terraform"
  tags                                        = {}
  zone_redundancy_enabled                     = false
}

# __generated__ by Terraform from "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Web/serverfarms/asp-terraform"
resource "azurerm_app_service_plan" "main" {
  app_service_environment_id   = null
  is_xenon                     = false
  kind                         = "linux"
  location                     = "westeurope"
  maximum_elastic_worker_count = 1
  name                         = "asp-terraform"
  per_site_scaling             = false
  reserved                     = true
  resource_group_name          = "rg-terraform"
  tags                         = {}
  zone_redundant               = false
  sku {
    capacity = 1
    size     = "B1"
    tier     = "Basic"
  }
}

# __generated__ by Terraform from "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Compute/virtualMachines/vm-terraform"
resource "azurerm_virtual_machine" "main" {
  availability_set_id              = null
  delete_data_disks_on_termination = null
  delete_os_disk_on_termination    = null
  license_type                     = null
  location                         = "westeurope"
  name                             = "vm-terraform"
  network_interface_ids            = ["/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Network/networkInterfaces/vm-terraformVMNic"]
  primary_network_interface_id     = null
  proximity_placement_group_id     = null
  resource_group_name              = "rg-terraform"
  tags                             = {}
  vm_size                          = "Standard_DS1_v2"
  zones                            = []
  os_profile {
    admin_password = null # sensitive
    admin_username = "azureuser"
    computer_name  = "vm-terraform"
    custom_data    = null
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2SXD2alKvY6vixbgpxULdP/EIxTNccqvZTEO1sfcaswOPmUFxaO87JnJ4w+w446vQb/D847KJFxNql5OvLAFaoV1JT4YvrWw6D63wtZt/VwoTq5XDPnNFD8C6Ui4uwMCY2ZLcgg5suTCfe4lbyYWKkpFtFYK51eWrDA8UK3ndWFpwSgwR+FMDJ2qhCeMBSMSIVn6sAdPOvba1+gDQ1ELT8aLCXcdpnmY8yU/srj4b9qIGkZ01/s1OmJnUU3pdv41ygb4WB9rArGjWjl4+y9en6s4kPsUuUveij7+av7RqMwcy3Pb/61usoUILO9vahIe9T5PGsO7hPAKOkxEUIvEZ"
      path     = "/home/azureuser/.ssh/authorized_keys"
    }
  }
  storage_image_reference {
    id        = null
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    caching                   = "ReadWrite"
    create_option             = "FromImage"
    disk_size_gb              = 30
    image_uri                 = null
    managed_disk_id           = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Compute/disks/vm-terraform_disk1_7db2f8d581d1456ba39aa16c39ea35b7"
    managed_disk_type         = "Premium_LRS"
    name                      = "vm-terraform_disk1_7db2f8d581d1456ba39aa16c39ea35b7"
    os_type                   = "Linux"
    vhd_uri                   = null
    write_accelerator_enabled = false
  }
}

# __generated__ by Terraform from "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.App/containerApps/containerapp-terraform"
resource "azurerm_container_app" "main" {
  container_app_environment_id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.App/managedEnvironments/containerapp-terraform"
  name                         = "containerapp-terraform"
  resource_group_name          = "rg-terraform"
  revision_mode                = "Single"
  tags                         = {}
  template {
    max_replicas    = 10
    min_replicas    = 0
    revision_suffix = null
    container {
      args    = []
      command = []
      cpu     = 0.25
      image   = "nginx"
      memory  = "0.5Gi"
      name    = "containerapp-terraform"
    }
  }
}

# __generated__ by Terraform
resource "azurerm_app_service" "main" {
  app_service_plan_id             = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.Web/serverfarms/asp-terraform"
  app_settings                    = {}
  client_affinity_enabled         = true
  client_cert_enabled             = false
  client_cert_mode                = "Required"
  enabled                         = true
  https_only                      = false
  key_vault_reference_identity_id = "SystemAssigned"
  location                        = "westeurope"
  name                            = "webapp-terraform"
  resource_group_name             = "rg-terraform"
  tags                            = {}
  auth_settings {
    additional_login_params        = {}
    allowed_external_redirect_urls = []
    default_provider               = null
    enabled                        = false
    issuer                         = null
    runtime_version                = null
    token_refresh_extension_hours  = 0
    token_store_enabled            = false
    unauthenticated_client_action  = null
  }
  logs {
    detailed_error_messages_enabled = false
    failed_request_tracing_enabled  = false
    application_logs {
      file_system_level = "Off"
    }
    http_logs {
    }
  }
  site_config {
    acr_use_managed_identity_credentials = false
    acr_user_managed_identity_client_id  = null
    always_on                            = false
    app_command_line                     = null
    auto_swap_slot_name                  = null
    default_documents                    = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"]
    dotnet_framework_version             = "v4.0"
    ftps_state                           = "FtpsOnly"
    health_check_path                    = null
    http2_enabled                        = true
    ip_restriction                       = []
    java_container                       = null
    java_container_version               = null
    java_version                         = null
    linux_fx_version                     = "DOTNETCORE|8.0"
    local_mysql_enabled                  = false
    managed_pipeline_mode                = "Integrated"
    min_tls_version                      = "1.2"
    number_of_workers                    = 1
    php_version                          = null
    python_version                       = null
    remote_debugging_enabled             = false
    remote_debugging_version             = null
    scm_ip_restriction                   = []
    scm_type                             = "None"
    scm_use_main_ip_restriction          = false
    use_32_bit_worker_process            = true
    vnet_route_all_enabled               = false
    websockets_enabled                   = false
    windows_fx_version                   = null
  }
  source_control {
    branch             = "main"
    manual_integration = false
    repo_url           = null
    rollback_enabled   = false
    use_mercurial      = false
  }
}

# __generated__ by Terraform from "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.ContainerService/managedClusters/aks-terraform/agentPools/npapps"
resource "azurerm_kubernetes_cluster_node_pool" "main" {
  capacity_reservation_group_id = null
  custom_ca_trust_enabled       = false
  enable_auto_scaling           = false
  enable_host_encryption        = false
  enable_node_public_ip         = false
  eviction_policy               = null
  fips_enabled                  = false
  host_group_id                 = null
  kubelet_disk_type             = "OS"
  kubernetes_cluster_id         = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.ContainerService/managedClusters/aks-terraform"
  max_count                     = 0
  max_pods                      = 110
  message_of_the_day            = null
  min_count                     = 0
  mode                          = "User"
  name                          = "npapps"
  node_count                    = 1
  node_labels                   = {}
  node_public_ip_prefix_id      = null
  node_taints                   = []
  orchestrator_version          = "1.26.6"
  os_disk_size_gb               = 128
  os_disk_type                  = "Managed"
  os_sku                        = "Ubuntu"
  os_type                       = "Linux"
  pod_subnet_id                 = null
  priority                      = "Regular"
  proximity_placement_group_id  = null
  scale_down_mode               = "Delete"
  snapshot_id                   = null
  spot_max_price                = -1
  tags                          = {}
  ultra_ssd_enabled             = false
  vm_size                       = "Standard_B2s"
  vnet_subnet_id                = null
  workload_runtime              = "OCIContainer"
  zones                         = []
}

# __generated__ by Terraform
resource "azurerm_key_vault" "main" {
  access_policy = [{
    application_id          = ""
    certificate_permissions = ["all"]
    key_permissions         = ["all"]
    object_id               = "99b281c9-823c-4633-af92-8ac556a19bee"
    secret_permissions      = ["all"]
    storage_permissions     = ["all"]
    tenant_id               = "16b3c013-d300-468d-ac64-7eda0820b6d3"
  }]
  enable_rbac_authorization       = false
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  location                        = "westeurope"
  name                            = "kv12357913tf01"
  public_network_access_enabled   = true
  purge_protection_enabled        = false
  resource_group_name             = "rg-terraform"
  sku_name                        = "standard"
  soft_delete_retention_days      = 90
  tags                            = {}
  tenant_id                       = "16b3c013-d300-468d-ac64-7eda0820b6d3"
  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

# __generated__ by Terraform
resource "azurerm_kubernetes_cluster" "main" {
  automatic_channel_upgrade           = null
  azure_policy_enabled                = null
  custom_ca_trust_certificates_base64 = []
  disk_encryption_set_id              = null
  dns_prefix                          = "aks-terraf-rg-terraform-82f6d7"
  dns_prefix_private_cluster          = null
  edge_zone                           = null
  http_application_routing_enabled    = null
  image_cleaner_enabled               = null
  image_cleaner_interval_hours        = null
  kubernetes_version                  = "1.26.6"
  local_account_disabled              = false
  location                            = "westeurope"
  name                                = "aks-terraform"
  node_os_channel_upgrade             = null
  node_resource_group                 = "MC_rg-terraform_aks-terraform_westeurope"
  oidc_issuer_enabled                 = false
  open_service_mesh_enabled           = null
  private_cluster_enabled             = false
  private_cluster_public_fqdn_enabled = false
  private_dns_zone_id                 = null
  resource_group_name                 = "rg-terraform"
  role_based_access_control_enabled   = true
  run_command_enabled                 = true
  sku_tier                            = "Free"
  tags                                = {}
  workload_identity_enabled           = false
  default_node_pool {
    capacity_reservation_group_id = null
    custom_ca_trust_enabled       = false
    enable_auto_scaling           = false
    enable_host_encryption        = false
    enable_node_public_ip         = false
    fips_enabled                  = false
    host_group_id                 = null
    kubelet_disk_type             = "OS"
    max_count                     = 0
    max_pods                      = 110
    message_of_the_day            = null
    min_count                     = 0
    name                          = "nodepool1"
    node_count                    = 1
    node_labels                   = {}
    node_public_ip_prefix_id      = null
    node_taints                   = []
    only_critical_addons_enabled  = false
    orchestrator_version          = "1.26.6"
    os_disk_size_gb               = 128
    os_disk_type                  = "Managed"
    os_sku                        = "Ubuntu"
    pod_subnet_id                 = null
    proximity_placement_group_id  = null
    scale_down_mode               = "Delete"
    snapshot_id                   = null
    tags                          = {}
    temporary_name_for_rotation   = null
    type                          = "VirtualMachineScaleSets"
    ultra_ssd_enabled             = false
    vm_size                       = "Standard_DS2_v2"
    vnet_subnet_id                = null
    workload_runtime              = "OCIContainer"
    zones                         = []
  }
  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
  kubelet_identity {
    client_id                 = "52ae7539-062d-43a3-a4a0-4669ceab5ba0"
    object_id                 = "d96aee84-1e72-4d77-92d5-c6bddfea0f3b"
    user_assigned_identity_id = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/MC_rg-terraform_aks-terraform_westeurope/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aks-terraform-agentpool"
  }
  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2SXD2alKvY6vixbgpxULdP/EIxTNccqvZTEO1sfcaswOPmUFxaO87JnJ4w+w446vQb/D847KJFxNql5OvLAFaoV1JT4YvrWw6D63wtZt/VwoTq5XDPnNFD8C6Ui4uwMCY2ZLcgg5suTCfe4lbyYWKkpFtFYK51eWrDA8UK3ndWFpwSgwR+FMDJ2qhCeMBSMSIVn6sAdPOvba1+gDQ1ELT8aLCXcdpnmY8yU/srj4b9qIGkZ01/s1OmJnUU3pdv41ygb4WB9rArGjWjl4+y9en6s4kPsUuUveij7+av7RqMwcy3Pb/61usoUILO9vahIe9T5PGsO7hPAKOkxEUIvEZ"
    }
  }
  network_profile {
    dns_service_ip      = "10.0.0.10"
    ebpf_data_plane     = null
    ip_versions         = ["IPv4"]
    load_balancer_sku   = "standard"
    network_mode        = null
    network_plugin      = "kubenet"
    network_plugin_mode = null
    network_policy      = null
    outbound_type       = "loadBalancer"
    pod_cidr            = "10.244.0.0/16"
    pod_cidrs           = ["10.244.0.0/16"]
    service_cidr        = "10.0.0.0/16"
    service_cidrs       = ["10.0.0.0/16"]
    load_balancer_profile {
      idle_timeout_in_minutes     = 0
      managed_outbound_ip_count   = 1
      managed_outbound_ipv6_count = 0
      outbound_ip_address_ids     = []
      outbound_ip_prefix_ids      = []
      outbound_ports_allocated    = 0
    }
  }
}

# __generated__ by Terraform
resource "azurerm_key_vault_secret" "main" {
  content_type    = null
  expiration_date = null
  key_vault_id    = "/subscriptions/82f6d75e-85f4-434a-ab74-5dddd9fa8910/resourceGroups/rg-terraform/providers/Microsoft.KeyVault/vaults/kv12357913tf"
  name            = "terraform-backend-key"
  not_before_date = null
  tags = {
    file-encoding = "utf-8"
  }
  value = null # sensitive
}
