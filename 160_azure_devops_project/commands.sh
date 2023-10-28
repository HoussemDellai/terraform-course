# Create PAT token in Azure DevOps
# Replace it in providers.tf file

terraform init

terraform plan -out tfplan

terraform apply tfplan

terraform destroy