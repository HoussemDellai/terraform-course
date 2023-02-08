# make sure terraform CLI is installed
terraform

# initialize terraform Azure modules
terraform init

# plan and save the infra changes into tfplan file
terraform plan -out tfplan

# apply the infra changes
terraform apply tfplan

# now remove the vnet-c-1 and vnet-f-1 from main.tf file

# plan and save the infra changes into tfplan file
terraform plan -out tfplan

# now note the changes that will be made:
# vnet-c-1 and vnet-f-1 will be destroyed, that ius expected
# however, vnet-c-2 will be also deleted and recreated, that is not expected !
# The learning here is that count will try to always start with zero index and will not try to preserve the existing resources.

# delete the infra
terraform destroy