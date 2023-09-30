# Terraform import feature

## Introduction

You will learn in this demo how to import existing infrastructure into terraform configuration.

## How it works ?

To import an existing resource group for example, you will define an import block like following.

```hcl
import {
    id = "/subscriptions/82f6d75e-xxx/resourceGroups/rg-terraform"
    to = azurerm_resource_group.main
}
```

You will need the resource ID for the resource to import, for the ``id` parameter.
And you will need to specify the terraform resource type and name within the `to` parameter.

Then you run the terraform commands to initialize and generate the configuration.

```bash
terraform init

terraform plan -generate-config-out="generated.tf"
```

That will generate a ``generated.tf` file with the terraform configuration, like following.

```hcl
# __generated__ by Terraform from "/subscriptions/xxx/resourceGroups/rg-terraform"
resource "azurerm_resource_group" "main" {
  location   = "westeurope"
  managed_by = null
  name       = "rg-terraform"
  tags       = {}
}
```

Let's do the same with an `Azure Key vault` and a secret.

```hcl
import {
    id = "/subscriptions/82f6d75e-xxx/resourceGroups/rg-terraform/providers/Microsoft.KeyVault/vaults/kv12357913tf01"
    to = azurerm_key_vault.main
}

import {
    id = "https://kv12357913tf.vault.azure.net/secrets/terraform-backend-key/1ddace06fdbe4400a357474255564a2e"
    to = azurerm_key_vault_secret.main
}
```

Run the command to generate the configuration.
```bash
terraform plan -generate-config-out="generated.tf"
```

The generated configuration is the following.

```hcl
# __generated__ by Terraform
resource "azurerm_key_vault" "main" {
  access_policy = [{
    application_id          = ""
    certificate_permissions = ["all"]
    key_permissions         = ["all"]
    object_id               = "99b281c9-823c-4633-af92-8ac556a19bee"
    secret_permissions      = ["all"]
    storage_permissions     = ["all"]
    tenant_id               = "16b3c013-xxxxx"
  }]
  enable_rbac_authorization       = false
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  location                        = "westeurope"
  name                            = "kv12357913tf01"
  public_network_access_enabled   = true
  purge_protection_enabled        = false
  resource_group_name             = "rg-terraform"
  sku_name                        = "standard"
  soft_delete_retention_days      = 90
  tags                            = {}
  tenant_id                       = "16b3c013-xxx"
  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

# __generated__ by Terraform
resource "azurerm_key_vault_secret" "main" {
  content_type    = null
  expiration_date = null
  key_vault_id    = "/subscriptions/82f6d75e-xxx/resourceGroups/rg-terraform/providers/Microsoft.KeyVault/vaults/kv12357913tf"
  name            = "terraform-backend-key"
  not_before_date = null
  tags = {
    file-encoding = "utf-8"
  }
  value = null # sensitive
}
```

> Note how terraform didn't import the value of the secret.

You can export many other resources from Azure.
Check out the `commands.sh` script to create resources in Azure and test terraform import to see how it works with each resource.

## Conclusion

Terraform import block is still in preview, but you would expect it to get even more mature with more advanced features.