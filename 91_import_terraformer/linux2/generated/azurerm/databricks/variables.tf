data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/resource_group/terraform.tfstate"
  }
}

data "terraform_remote_state" "storage_account" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/storage_account/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnet" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/subnet/terraform.tfstate"
  }
}

data "terraform_remote_state" "virtual_network" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/virtual_network/terraform.tfstate"
  }
}
