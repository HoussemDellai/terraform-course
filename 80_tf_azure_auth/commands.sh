# create Azure Service Principal (SPN)
az ad sp create-for-rbac -n terraform-spn

# sample output:
# Changing "terraform-spn" to a valid URI of "http://terraform-spn", which is the required format used for service principal names
# In a future release, this command will NOT create a 'Contributor' role assignment by default. 
# If needed, use the --role argument to explicitly create a role assignment.
# Creating 'Contributor' role assignment under scope '/subscriptions/0cb12691-4f8e-4a66-abab-xxxxxxxxxxxx'
#   Retrying role assignment creation: 1/36
#   Retrying role assignment creation: 2/36
# The output includes credentials that you must protect. Be sure that you do not include these credentials in your code 
# or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
# {
#   "appId": "8df55d66-2860-4349-xxxx-da9ad1b9a450",
#   "displayName": "terraform-spn",
#   "name": "http://terraform-spn",
#   "password": "sgnYoSiHS-~XXXXXXX-z8~-3~vjCkQfZm9",
#   "tenant": "558506eb-9459-4ef3-b920-xxxxxxxxxx"
# }

# In main.tf file, change the following section with creadentials frim your created SPN:

# provider "azurerm" {
#   features {}
#   subscription_id = "0cb12691-4f8e-4a66-abab-xxxxxxxxxxxx"
#   client_id       = "8df55d66-2860-4349-xxxx-da9ad1b9a450"
#   client_secret   = "sgnYoSiHS-~XXXXXXX-z8~-3~vjCkQfZm9"
#   tenant_id       = "558506eb-9459-4ef3-b920-xxxxxxxxxx"
# }

# get terraform version
terraform version
# Terraform v0.15.0

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