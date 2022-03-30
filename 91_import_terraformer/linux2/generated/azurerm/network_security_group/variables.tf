data "terraform_remote_state" "network_security_group" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/network_security_group/terraform.tfstate"
  }
}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/resource_group/terraform.tfstate"
  }
}
