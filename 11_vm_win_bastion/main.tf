resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#------------------------------------------------------###################
# VNET & Subnets
#------------------------------------------------------###################

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "vm" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/27"]
}

#------------------------------------------------------###################
# VM for BASTION
#------------------------------------------------------###################

resource "azurerm_network_interface" "vm" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.windows_vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vm.id]
  size                  = "Standard_DS1_v2"
  admin_username        = "houssem"
  admin_password        = "@Aa123456789"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h1-pro-g2"
    version   = "latest"
  }
}

#------------------------------------------------------###################
# BASTION
#------------------------------------------------------###################

resource "azurerm_public_ip" "bastion" {
  name                = "bastionip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}

#--------------------------------------------------------------------------
# Install tools in Bastion VM
#--------------------------------------------------------------------------

// resource "azurerm_virtual_machine_extension" "extension" {
//   name                 = "k8s-tools-deploy"
//   virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
//   publisher            = "Microsoft.Azure.Extensions"
//   type                 = "CustomScript"
//   type_handler_version = "1.9.5" # "2.0"

//   settings = <<SETTINGS
//     {
//         "script": "hostname"
//     }
// SETTINGS

// //   settings = <<SETTINGS
// //     {
// //         "script": "hostname"
// //         # "commandToExecute": "hostname"
// //     }
// // SETTINGS
// }

// resource "azurerm_virtual_machine_extension" "extension" {
//   name                 = "k8s-tools-deploy01"
//   virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
//   publisher            = "Microsoft.Compute"
//   type                 = "CustomScriptExtension"
//   type_handler_version = "1.9.5" # "2.0"

//   settings = <<SETTINGS
//     {
//         "script": "hostname"
//     }
// SETTINGS

// //   settings = <<SETTINGS
// //     {
// //         "script": "hostname"
// //         # "commandToExecute": "hostname"
// //     }
// // SETTINGS
// }

# # Install Azure CLI
# Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
#
# # Install chocolately
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#
# # Install Kubernetes CLI
# choco install kubernetes-cli
#
# # Install Helm CLI
# choco install kubernetes-helm