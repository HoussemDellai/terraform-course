# Deep dive into Terraform modules dependencies

## Introduction

In this lab, you will deep dive into learning Terraform modules dependencies.
Through examples, you will learn how Terraform manages the chaining of resource creation regarding dependencies.
This will allow you to better understand Terraform behaviour and optimize resource creation time.

You will work with two sample modules provided under the `\modules` folder: keyvault and storage_account.
Keyvaul module creates an Azure Key vault and a Public IP resources.
Storage_account creates an Azure Storage Account and a Public IP resources.
The Public IP resource has nothing to do with the storage account or key vault.
It is needed just for demoing purposes.

Both modules depends implicitly on the resource group created at the root resource as they reference the resource group name and location.

## Scenario 1: No dependencies between modules

In this scenarion, module storage account does not depend on module keyvault.
There are no explicit or implicit dependency.
As a result, the creation of the resources will happen in parallel.
Let's run two independant modules and see what will happen.
Make sure that only resource group, key vault and storage account are uncommented.

```terraform
terraform init
terraform apply -auto-approve

# azurerm_resource_group.rg: Creating...
# azurerm_resource_group.rg: Creation complete after 2s
# module.storage_account.azurerm_public_ip.pip: Creating...
# module.keyvault.azurerm_key_vault.keyvault: Creating...
# module.keyvault.azurerm_public_ip.pip: Creating...
# module.storage_account.azurerm_storage_account.storage: Creating...
```

Note from the output, because there is no dependencies between modules, the resources will be created in parallel.

> Resources from independant modules will be created in parallel, with no specified order.

Cleanup the resources before continuing with the next scenario.

```terraform
terraform destroy -auto-approve
```

## Scenario 2: module storage_account depends explicitly on module keyvault

## Scenario 3: module storage_account depends explicitly only on Public IP from module keyvault

## Scenario 4: module storage_account depends implicitly on module keyvault

## Conclusion


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./modules/keyvault | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/storage_account | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->