data "terraform_remote_state" "network_watcher" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/network_watcher/terraform.tfstate"
  }
}

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
