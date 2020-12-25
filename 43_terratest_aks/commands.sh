# src tf template: https://github.com/gruntwork-io/terratest/tree/master/examples/azure/terraform-azure-aks-example
# src terratest test: https://github.com/gruntwork-io/terratest/blob/master/test/azure/terraform_azure_aks_example_test.go

az login 
export ARM_SUBSCRIPTION_ID={YOUR_SUBSCRIPTION_ID} 
export TF_VAR_client_id={YOUR_SERVICE_PRINCIPAL_APP_ID}
export TF_VAR_client_secret={YOUR_SERVICE_PRINCIPAL_PASSWORD}

go mod init "tftest"
go test -v

# Running this module manually
# $ az login 
# $ az ad sp create-for-rbac
# $ export ARM_SUBSCRIPTION_ID={YOUR_SUBSCRIPTION_ID} 
# $ export TF_VAR_client_id={YOUR_SERVICE_PRINCIPAL_APP_ID}
# $ export TF_VAR_client_secret={YOUR_SERVICE_PRINCIPAL_PASSWORD}
# $ terraform init
# $ terraform apply
# $ kubectl --kubeconfig ./kubeconfig -f ./nginx-deployment.yml
# $ kubectl --kubeconfig ./kubeconfig get svc -w
# // Open browser and access the Nginx Service IPAddress
# $ terraform destroy