# Using Azure Grafana and Prometheus workspace in AKS using Terraform

## Introduction

This lab shows how to use Terraform to provision an AKS cluster, Grafana and Monitor Workspace for Prometheus. All configured together to collect metrics from the cluster and expose it through Grafana dashboard.

<img src="images\architecture.png">

## Challenges

Azure Monitor Workspace for Prometheus is a new service (in preview).
It is not yet supported with ARM template or with Terraform resource.

So, we'll use `azapi` terraform provider to create the Monitor Workspace for Prometheus.

And we'll use a `local-exec` to run a command line to configure AKS with Prometheus.

AKS, Grafana and Log Analytics are suported with ARM templates and Terraform.

## Deploying the resources using Terraform

To deploy the Terraform configuration files, run the following commands:

```shell
terraform init

terraform plan -out tfplan

terraform apply tfplan
```

## Cleanup resources

To delete the creates resources, run the following command:

```shell
terraform destroy
```