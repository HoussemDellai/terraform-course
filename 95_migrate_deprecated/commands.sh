# Migrating from Deprecated Terraform Resources
# Official doc: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/migrating-from-deprecated-resources

# Introduction
# This guide shows how to migrate from a resource which has been deprecated or renamed to its replacement.
# It's possible to migrate between the resources in 3 steps:

# 1- removing deprecated resource from state
# 2- updating Terraform Configuration
# 3- importing the new resource into the state

# In this guide, we'll assume we're migrating from the azurerm_app_service resource to the new azurerm_linux_web_app resource, 
# but this should also be applicable for resources that have only been renamed 
# where you can simply change the resource type name in your config.

# main.tf file contains both deprecated and new resource types.
# make sure to uncomment the deprecated resources and comment the new ones.

# deploy deprecated resources

terraform init

terraform plan -out tfplan

terraform apply tfplan

# start the migration

# 1- removing deprecated resource from state

# show the state file, note the resources section with all the tracked resources
cat terraform.tfstate

# list the tracked files from the state
terraform state list
# azurerm_app_service.app
# azurerm_app_service_plan.plan
# azurerm_resource_group.rg

# get the resource id of the app service plan
echo azurerm_app_service_plan.plan.id | terraform console   
# "/subscriptions/4b72ed90-7ca3-4e76-8d0f-XXXXXXXXXXX/resourceGroups/MyResourceGroup/providers/Microsoft.Web/serverfarms/MyAppServicePlan"
APP_SERVICE_PLAN_RESOURCE_ID=$(echo azurerm_app_service_plan.plan.id | terraform console)

# get the resource id of the app service
echo azurerm_app_service.app.id | terraform console
# "/subscriptions/4b72ed90-7ca3-4e76-8d0f-XXXXXXXXXXX/resourceGroups/MyResourceGroup/providers/Microsoft.Web/sites/mywebapp-01357"
APP_SERVICE_RESOURCE_ID=$(echo azurerm_app_service.app.id | terraform console)

# remove the existing tracked resources from the state file
terraform state rm azurerm_app_service.app azurerm_app_service_plan.plan

# note how the resources are removed from the state file
cat terraform.tfstate

# 2- updating Terraform Configuration

# comment the deprecated resources in main.tf and uncomment the new ones.

# 3- importing the new resource into the state

# import the new resource type into terraform state
terraform import azurerm_service_plan.plan $APP_SERVICE_PLAN_RESOURCE_ID

terraform import azurerm_linux_web_app.app $APP_SERVICE_RESOURCE_ID

# note how the new resource types are added to the state file
terraform state list
cat terraform.tfstate

# check the config
terraform plan