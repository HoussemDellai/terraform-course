## Using Kubernetes provider to connect to RBAC enabled AKS cluster

### Introduction
This demo shows how to use Terraform Kubernetes provider to connect to RBAC enabled AKS cluster.
The authentication is done 

### Install CLI tools
The following CLI tools should be installed: Terraform CLI, Azure CLI, Kubernetes CLI and Kubelogin CLI.
Make sure you also have the required access rights to create an Azure AD Group and Service Principal. 

```bash
# connect to Azure subscription
az login
```

```bash
# make sure terraform CLI is installed
terraform
```

```bash
# format the tf files
terraform fmt
```

```bash
# initialize Azure terraform modules
terraform init
```

```bash
# validate the template
terraform validate
```

```bash
# plan and save the infra changes into tfplan file
terraform plan -out tfplan
```

```bash
# check the plan
terraform show -json tfplan | jq '.' | jq -r '(.resource_changes[] | [.change.actions[], .type, .change.after.name]) | @tsv'
```

```bash
# apply the infra changes
terraform apply tfplan
```

```bash
# check the state 
terraform state list
```

```bash
# connect to AKS cluster
az aks get-credentials --name aks-cluster --resource-group rg_aks_terraform --overwrite-existing
```

```bash
# cluster authN & authZ is needed, so this won't work
kubectl get nodes
```

```bash
# connect with kubelogin and Azure CLI identity
kubelogin convert-kubeconfig -l azurecli
```

```bash
# now this works after auth using kubelogin
kubectl get nodes
# NAME                                 STATUS   ROLES   AGE     VERSION
# aks-systempool-15239186-vmss000000   Ready    agent   7m30s   v1.23.5
# aks-systempool-15239186-vmss000001   Ready    agent   7m40s   v1.23.5
```

```bash
# now lets check if Terraform succeeded to create the namespace
kubectl get ns
# NAME              STATUS   AGE
# apps-namespace    Active   6m48s
# default           Active   8m55s
# kube-node-lease   Active   8m58s
# kube-public       Active   8m58s
# kube-system       Active   8m58s
```

```bash
kubectl get pods -n frontend-app-namespace
# NAME                           READY   STATUS    RESTARTS   AGE
# deploy-nginx-885db74d7-7zb67   1/1     Running   0          6h32m
# deploy-nginx-885db74d7-kc798   1/1     Running   0          6h32m
# deploy-nginx-885db74d7-m4xv9   1/1     Running   0          6h32m
# pod-nginx                      1/1     Running   0          6h32m
```

```bash
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
```

```bash
# delete the infra
terraform destroy
```

```bash
# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm tfplan
rm tfplan.json
rm -r .terraform/
```