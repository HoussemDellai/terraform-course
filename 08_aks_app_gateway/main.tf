resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Locals block for hardcoded names
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rqrt"
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.virtual_network_address_prefix]

  subnet {
    name           = var.aks_subnet_name
    address_prefix = var.aks_subnet_address_prefix
  }

  subnet {
    name           = var.app_gateway_subnet_name
    address_prefix = var.app_gateway_subnet_address_prefix
  }

  tags = var.tags
}

data "azurerm_subnet" "kubesubnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

data "azurerm_subnet" "appgwsubnet" {
  name                 = var.app_gateway_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  depends_on           = [azurerm_virtual_network.vnet]
}

# Public Ip 
resource "azurerm_public_ip" "pip" {
  name                = "publicIp-appgw"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.app_gateway_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.resource_group_location

  sku {
    name     = var.app_gateway_sku
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = data.azurerm_subnet.appgwsubnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  tags = var.tags

  depends_on = [azurerm_virtual_network.vnet, azurerm_public_ip.pip]
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name               = var.aks_name
  location           = azurerm_resource_group.rg.location
  kubernetes_version = "1.22.6"
  dns_prefix         = var.aks_dns_prefix

  resource_group_name = azurerm_resource_group.rg.name
  node_resource_group = var.node_resource_group

  linux_profile {
    admin_username = var.vm_user_name

    ssh_key {
      key_data = file(var.public_ssh_key_path)
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.aks_agent_count
    vm_size         = var.aks_agent_vm_size
    os_disk_size_gb = var.aks_agent_os_disk_size
    vnet_subnet_id  = data.azurerm_subnet.kubesubnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure" # "kubenet" # 
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr
    service_cidr       = var.aks_service_cidr
  }

  role_based_access_control {
    enabled = var.aks_enable_rbac
  }

  addon_profile {
    ingress_application_gateway {
      enabled    = true
      gateway_id = azurerm_application_gateway.appgw.id
      # other options if we want to allow the AGIC addon to create a new AppGW 
      # and not use an existing one
      # subnet_id    = # link AppGW to specific Subnet
      # gateway_name = # give a name to the generated AppGW
      # subnet_cidr  = # specify the CIDR range for the Subnet that will be created
    }
  }

  depends_on = [azurerm_virtual_network.vnet, azurerm_application_gateway.appgw]
  tags       = var.tags
}

# AppGW (generated with addon) Identity needs also Contributor role over AKS/VNET RG
resource "azurerm_role_assignment" "ra" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_user_assigned_identity.identity-appgw.principal_id

  depends_on = [azurerm_kubernetes_cluster.k8s, azurerm_application_gateway.appgw]
}

# generated managed identity for app gateway
data "azurerm_user_assigned_identity" "identity-appgw" {
  name                = "ingressapplicationgateway-${var.aks_name}"
  resource_group_name = var.node_resource_group

  depends_on = [azurerm_kubernetes_cluster.k8s]
}
