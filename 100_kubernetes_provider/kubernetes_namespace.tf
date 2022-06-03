# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1
resource "kubernetes_namespace_v1" "ns" {

  metadata {
    name = var.kube_namespace

    annotations = {
      name = "sample-annotation"
    }

    labels = {
      tier = "frontend"
    }
  }
}