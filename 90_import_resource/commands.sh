# demo for importing existing infrastructure into Terraform configuration files
# create an Azure Resource Group and a Storage Account
az group create -g myResourceGroup -l westeurope
az storage account create -g myResourceGroup -n tfsademo01

# in main.tf we created the tf resource for the resource group & storage account

# init terraform's Azure provider
terraform init

# replace $SUBSCRIPTION_ID with your own subscription ID
$SUBSCRIPTION_ID="replace here"

# import the above created resource group into terraform state file
terraform import azurerm_resource_group.rg '/subscriptions/$SUBSCRIPTION_ID/resourceGroups/myResourceGroup'

# importing the resource group doesn't automatically import its child resources
# import the storage account
terraform import azurerm_storage_account.storage '/subscriptions/$SUBSCRIPTION_ID/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/tfsademo01'

# check the content of the terraform.state file to notice a new section for the RG
# starting from now, we can manage this resource group using terraform
# try for example to rename the resource group in main.tf , then preview the changes

# plan and preview terraform changes
terraform plan

# cleanup created resources
az group delete -g myResourceGroup