data "terraform_remote_state" "data_factory" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/data_factory/terraform.tfstate"
  }
}

data "terraform_remote_state" "databricks" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/databricks/terraform.tfstate"
  }
}

data "terraform_remote_state" "keyvault" {
  backend = "local"

  config = {
    path = "../../../generated/azurerm/keyvault/terraform.tfstate"
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
