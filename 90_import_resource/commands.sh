# create Azure Resource Group
az group create -g rg-terraform-import -l westeurope

# get terraform version
terraform version
# Terraform v1.15.0

# get terraform commands
terraform

# init terraform's Azure provider (main.tf)
terraform init

# plan and preview terraform changes
terraform plan

# deploy terraform infra
terraform apply

# destroy infra
terraform destroy