STORAGE_ACCOUNT_NAME=storagetfstate011
RESOURCE_GROUP_NAME=rg-terraform-state
CONTAINER_NAME=tfstate
BLOB_NAME=terraform.tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location westeurope

# Create storage account
az storage account create --name $STORAGE_ACCOUNT_NAME \
   --resource-group $RESOURCE_GROUP_NAME \
   --sku Standard_LRS \
   --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# generate backend.tf file
cat <<EOT > backend.tf
terraform {
  backend "azurerm" {
    resource_group_name   = "$RESOURCE_GROUP_NAME"
    storage_account_name  = "$STORAGE_ACCOUNT_NAME"
    container_name        = "$CONTAINER_NAME"
    key                   = "$BLOB_NAME"
  }
}
EOT