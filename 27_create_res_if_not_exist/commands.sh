# Assume we have an existing Resource Group
az group create -n rg-demo -l westeurope

# initialize terraform Azure modules
terraform init

# plan and save the infra changes into tfplan file
terraform plan -out tfplan
# Terraform will perform the following actions:

#   # azurerm_resource_group.rg will be created
#   + resource "azurerm_resource_group" "rg" {
#       + id       = (known after apply)
#       + location = "westeurope"
#       + name     = "rg-demo"
#     }

# Plan: 1 to add, 0 to change, 0 to destroy.

# apply the infra changes
terraform apply tfplan

# run plan command 'offline'
terraform plan -out tfplan -refresh=false

# update the state file without deploying resources
terraform apply -refresh-only

# remove resource from the state
terraform state list
terraform state rm azurerm_subnet.subnet_01
terraform state list

# delete the infra
terraform destroy

# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm tfplan
rm tfplan.json
rm -r .terraform/