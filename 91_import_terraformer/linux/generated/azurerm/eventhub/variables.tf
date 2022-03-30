data "terraform_remote_state" "eventhub" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/eventhub/terraform.tfstate"
  }
}

data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/resource_group/terraform.tfstate"
  }
}
