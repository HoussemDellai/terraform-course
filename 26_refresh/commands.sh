# make sure terraform CLI is installed
terraform

# initialize terraform Azure modules
terraform init

# plan and save the infra changes into tfplan file
terraform plan -out tfplan

# apply the infra changes
terraform apply tfplan

# run plan command 'offline'
terraform plan -out tfplan -refresh=false

# update the state file without deploying resources
terraform apply -refresh-only

terraform plan -out tfplan -target azurerm_subnet.subnet_01

# remove resource from the state
terraform state list
terraform state rm azurerm_subnet.subnet_01
terraform state list

# delete the infra
terraform destroy