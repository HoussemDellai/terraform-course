data "terraform_remote_state" "storage_account" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/storage_account/terraform.tfstate"
  }
}
