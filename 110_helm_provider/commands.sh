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
az aks get-credentials --name aks-cluster --resource-group rg_aks_terraform_helm --overwrite-existing

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

kubectl get deploy -A

# note about Azure Kubernetes Service AAD Server
az ad sp show --id 6dae42f8-4368-4678-94ff-3960e28e3630
# {
#   "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#servicePrincipals/$entity",
#   "accountEnabled": true,
#   "addIns": [],
#   "alternativeNames": [],
#   "appDescription": null,
#   "appDisplayName": "Azure Kubernetes Service AAD Server",
#   "appId": "6dae42f8-4368-4678-94ff-3960e28e3630",
#   "appOwnerOrganizationId": "f8cdef31-a31e-4b4a-93e4-5f571e91255a",
#   "appRoleAssignmentRequired": false,
#   "appRoles": [],
#   "applicationTemplateId": null,
#   "createdDateTime": "2021-04-23T14:33:46Z",
#   "deletedDateTime": null,
#   "description": null,
#   "disabledByMicrosoftStatus": null,
#   "displayName": "Azure Kubernetes Service AAD Server",
#   "homepage": null,
#   "id": "5dc776ad-9525-4afd-ad24-334e21ad710e",


# delete the infra
terraform destroy

# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm tfplan
rm tfplan.json
rm -r .terraform/