# demo for importing existing infrastructure into Terraform configuration files
# create an Azure Resource Group
az group create -g myResourceGroup -l westeurope

# we use the main.tf where we created the tf resource for the resource group

# init terraform's Azure provider
terraform init

# import the above created resource group into terraform state file
terraform import azurerm_resource_group.rg '/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/myResourceGroup'

# check the content of the terraform.state file to notice a new section for the RG
# starting from now, we can manage this resource group using terraform
# try for example to rename the resource group in main.tf , then preview the changes

# plan and preview terraform changes
terraform plan

# deploy terraform infra
terraform apply

# destroy infra
terraform destroy