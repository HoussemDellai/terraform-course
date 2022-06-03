resource "helm_release" "example" {
  name       = "my-redis-release"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  # repository = "https://vmware-tanzu.github.io/helm-charts" # "https://charts.bitnami.com/bitnami"
  # chart      = "velero" # "redis"
  # version    = "6.0.1"

  # values = [
  #   "${file("values.yaml")}"
  # ]

  # set {
  #   name  = "cluster.enabled"
  #   value = "true"
  # }

  # set {
  #   name  = "metrics.enabled"
  #   value = "true"
  # }

  # set {
  #   name  = "service.annotations.prometheus\\.io/port"
  #   value = "9127"
  #   type  = "string"
  # }
}