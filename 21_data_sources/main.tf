#----------------------------------------------------------------
# Machine IP
#----------------------------------------------------------------

data "http" "my_ip" {
  url = "http://ifconfig.me"
}

output "myIp" {
  value = data.http.my_ip.body
}

#----------------------------------------------------------------
# Terraform latest version
#----------------------------------------------------------------

data "http" "tf_latest" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  request_headers = {
    Accept = "application/json"
  }
}

output "terraform_latest_version" {
  value = jsondecode(data.http.tf_latest.body).current_version
}

#----------------------------------------------------------------
# AzureRM provider latest version
#----------------------------------------------------------------

data "http" "azurerm_latest" {
  url = "https://api.github.com/repos/terraform-providers/terraform-provider-azurerm/releases/latest"

  request_headers = {
    Accept = "application/json"
  }
}

output "azurerm_latest_version" {
  value = jsondecode(data.http.azurerm_latest.body).name
}

#----------------------------------------------------------------
# AKS/Kubernetes versions
#----------------------------------------------------------------

data "azurerm_kubernetes_service_versions" "current" {
  location        = "West Europe"
  include_preview = true
}

output "versions" {
  value = data.azurerm_kubernetes_service_versions.current.versions
}

output "aks_latest_version" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}

#----------------------------------------------------------------
# local-exec
#----------------------------------------------------------------

resource "null_resource" "time_now" {
  provisioner "local-exec" {
    command = "Get-Date > date.txt"
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "null_resource" "ip_info" {
  provisioner "local-exec" {
    command = join(" ", [
      "echo",
      "My machine IP adress:",
      data.http.my_ip.body,
      ">",
      "info.txt"])
  }
}

#----------------------------------------------------------------
# remote-exec
#----------------------------------------------------------------

resource "null_resource" "remote" {
  provisioner "remote-exec" {
    connection {
      host     = azurerm_public_ip.windows.ip_address
      type     = "winrm"
      port     = 5985
      https    = false
      timeout  = "5m"
      user     = var.admin_username
      password = var.admin_password
    }
    inline = [
      "powershell.exe -ExecutionPolicy Unrestricted -Command {Install-WindowsFeature -name Web-Server -IncludeManagementTools}",
    ]
  }
}