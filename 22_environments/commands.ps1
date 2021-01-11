# get terraform version
terraform version
# Terraform v0.14.4

# get terraform commands
terraform

# init terraform's Azure provider (main.tf)
terraform init

# plan & preview changes in dev env
terraform plan -out .\dev\dev.tfplan `
               -state .\dev\dev.tfstate `
               -var-file .\dev\dev.tfvars

# deploy infra into dev environment
terraform apply -state .\dev\dev.tfstate `
                .\dev\dev.tfplan

# plan & preview changes in test env
terraform plan -out .\test\test.tfplan `
               -state .\test\test.tfstate `
               -var-file .\test\test.tfvars

# deploy infra into test environment
terraform apply -state .\test\test.tfstate `
                .\test\test.tfplan

# plan & preview changes in prod env
terraform plan -out .\prod\prod.tfplan `
               -state .\prod\prod.tfstate `
               -var-file .\prod\prod.tfvars

# deploy infra into test environment
terraform apply -state .\prod\prod.tfstate `
                .\prod\prod.tfplan

# Destroy dev env
terraform destroy -state .\dev\dev.tfstate `
                  -var-file .\dev\dev.tfvars