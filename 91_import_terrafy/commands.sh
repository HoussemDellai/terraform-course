# Generate Terraform configuration and state from existing Azure resources

# Install Azure Terrafy
go install github.com/Azure/aztfy@latest

# Azure Terrafy commands
aztfy

# Azure Terrafy needs an empty folder to export config
mkdir terraform-web-sql

# Generate Terraform configuration and state file
aztfy -o terraform-web-sql rg-terraform-web-sql-db