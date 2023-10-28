terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "0.10.0"
    }
  }
}

provider "azuredevops" {
  # Configuration options
  org_service_url       = "https://dev.azure.com/houssemdellai"
  personal_access_token = "qkfon5cdldekin4qnkgfr2nf367h6yjnndm5upwqepd5rekl4l5a"
}

# export AZDO_PERSONAL_ACCESS_TOKEN=<Personal Access Token>
# export AZDO_ORG_SERVICE_URL=https://dev.azure.com/<Your Org Name>
