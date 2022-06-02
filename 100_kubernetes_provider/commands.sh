# make sure terraform CLI is installed
terraform

# format the tf files
terraform fmt

# initialize terraform Azure modules
terraform init

# validate the template
terraform validate

# plan and save the infra changes into tfplan file
terraform plan -out tfplan

# check the plan
terraform show -json tfplan | jq '.' | jq -r '(.resource_changes[] | [.change.actions[], .type, .change.after.name]) | @tsv'

# apply the infra changes
terraform apply tfplan

# check the state 
terraform state list

# connect to AKS cluster
az aks get-credentials --name aks-cluster --resource-group rg_aks_terraform --overwrite-existing

# cluster authN & authZ is needed, so this won't work
kubectl get nodes

# connect with kubelogin and Azure CLI identity
kubelogin convert-kubeconfig -l azurecli

# now this works after auth using kubelogin
kubectl get nodes
# NAME                                 STATUS   ROLES   AGE     VERSION
# aks-systempool-15239186-vmss000000   Ready    agent   7m30s   v1.23.5
# aks-systempool-15239186-vmss000001   Ready    agent   7m40s   v1.23.5

# now lets check if Terraform succeeded to create the namespace
kubectl get ns
# NAME              STATUS   AGE
# apps-namespace    Active   6m48s
# default           Active   8m55s
# kube-node-lease   Active   8m58s
# kube-public       Active   8m58s
# kube-system       Active   8m58s

# delete the infra
terraform destroy

# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm tfplan
rm tfplan.json
rm -r .terraform/