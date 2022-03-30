data "terraform_remote_state" "resource_group" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/resource_group/terraform.tfstate"
  }
}

data "terraform_remote_state" "route_table" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/route_table/terraform.tfstate"
  }
}
