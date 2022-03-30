data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/resource_group/terraform.tfstate"
  }
}

data "terraform_remote_state" "synapse" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/synapse/terraform.tfstate"
  }
}
