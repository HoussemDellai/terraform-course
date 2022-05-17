# make sure terraformer CLI is installed
# $ brew install terraformer
# $ sudo port install terraformer
choco install terraformer

# $ az login
# $ az account list -o table
$ARM_SUBSCRIPTION_ID="4b72ed90-7ca3-4e76-8d0f-31a2c0bee7a3"

terraformer import azure -r resource_group

terraformer import azure -R my_resource_group -r virtual_network,resource_group

terraformer import azure -r resource_group --filter=resource_group=/subscriptions/<Subscription id>/resourceGroups/<RGNAME>


# https://github.com/GoogleCloudPlatform/terraformer/blob/master/docs/azure.md



az ad sp create-for-rbac --name spn-terraformer
# The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
# {
#   "appId": "461607ed-0f46-46cb-bed6-XXXXXXXXXXXXX",
#   "displayName": "spn-terraformer",
#   "password": "U30bShJX.XXXXXXXXXXXXX",
#   "tenant": "72f988bf-XXXXXXXXXXXX"
# }
# make sure to assign Read RBAC role on Subscriptoion to the SPN

export ARM_SUBSCRIPTION_ID=<replace>

export ARM_CLIENT_ID=<replace>

export ARM_CLIENT_SECRET=<replace>

export ARM_TENANT_ID=<replace>

# create provider.tf file

terraform init

terraformer plan azure --output hcl --resource-group rg-aks-cluster --resources="*" --verbose