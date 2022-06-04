resource "helm_release" "pod_identity" {
  name       = "pod-identity"
  repository = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart      = "aad-pod-identity"
  namespace  = "kube-system"
  create_namespace = true
}

resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress-controller"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx-ingress-controller"
  namespace        = "ingress"
  create_namespace = true

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true
}

resource "helm_release" "argo_cd" {
  name             = "argo"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "argo-cd"
  version          = "3.3.8"
  namespace        = "gitops"
  create_namespace = true

  set {
    name = "server.service.type"
    value = "LoadBalancer"
  }
}

resource "helm_release" "redis" {
  name             = "redis"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "redis"
  version          = "16.11.2"
  namespace        = "redis-app"
  create_namespace = true

  # values = [
  #   "${file("values.yaml")}"
  # ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
    type  = "string"
  }
}