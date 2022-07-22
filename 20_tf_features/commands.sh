# make sure terraform CLI is installed
terraform

# format the tf files
terraform fmt

# initialize terraform Azure modules
terraform init

# validate the template
terraform validate

# plan and save the infra changes into tfplan file
# should fail validation
terraform plan -out tfplan -var rg_name="myRG" -var location="easteurope" 

# should display the 4 resources to be created
terraform plan -out tfplan -var rg_name="rg-main-app" -var location="westeurope"

# show the tfplan file
terraform show -json tfplan
terraform show -json tfplan >> tfplan.json

# show only the changes
terraform show -json tfplan | jq '.' | jq -r '(.resource_changes[] | [.change.actions[], .type, .change.after.name]) | @tsv'

# show only the changes to the specific targeted resources
terraform plan -out tfplan -target azurerm_resource_group.rg_tf_enabled_resource_for_each -target azurerm_resource_group.rg_tf_enabled_resource_count 
terraform plan -out tfplan -target azurerm_storage_account.storage_tf_enabled_resource_for_inner_block

# apply the infra changes
terraform apply tfplan

# show tracked resources in the state file
terraform state list

# delete the infra
terraform destroy

# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm .terraform.lock.hcl
rm tfplan
rm tfplan.json
rm -r .terraform/