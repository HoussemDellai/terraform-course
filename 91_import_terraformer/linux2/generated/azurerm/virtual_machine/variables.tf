data "terraform_remote_state" "network_interface" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/network_interface/terraform.tfstate"
  }
}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/resource_group/terraform.tfstate"
  }
}
