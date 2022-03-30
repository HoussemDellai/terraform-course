data "terraform_remote_state" "storage_account" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/storage_account/terraform.tfstate"
  }
}

data "terraform_remote_state" "storage_container" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/storage_container/terraform.tfstate"
  }
}
