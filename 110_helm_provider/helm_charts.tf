resource "helm_release" "pod_identity" {
  name       = "pod-identity"
  repository = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart      = "aad-pod-identity"
  namespace  = "kube-system"
}

# https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx
resource "helm_release" "nginx_ingress_controller" {
  name             = "nginx-ingress-controller"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.1.3"
  namespace        = "ingress"
  create_namespace = "true"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "controller.autoscaling.enabled"
    value = "true"
  }
  set {
    name  = "controller.autoscaling.minReplicas"
    value = "2"
  }
  set {
    name  = "controller.autoscaling.maxReplicas"
    value = "10"
  }
}

# https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
resource "helm_release" "prometheus_stack" {
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  set {
    name  = "grafana.ingress.enabled"
    value = "true"
  }
  set {
    name  = "grafana.ingress.ingressClassName"
    value = "nginx"
  }
  set {
    name  = "grafana.ingress.path"
    value = "/(.*)" # "/grafana2/?(.*)"
  }
  # annotations:
  #   nginx.ingress.kubernetes.io/ssl-redirect: "false"
  #   nginx.ingress.kubernetes.io/use-regex: "true"
  #   nginx.ingress.kubernetes.io/rewrite-target: /$1
  set {
    name  = "grafana.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/ssl-redirect"
    value = "false"
    type  = "string"
  }
  set {
    name  = "grafana.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/use-regex"
    value = "true"
    type  = "string"
  }
  set {
    name  = "grafana.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = "/$1"
  }
  set {
    name  = "grafana.adminUser"
    value = var.grafana_admin_user
  }
  set {
    name  = "grafana.adminPassword"
    value = var.grafana_admin_password
  }
}

resource "helm_release" "argo_cd" {
  name             = "argo"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "4.8.2"
  namespace        = "gitops"
  create_namespace = true

  # annotations:
  #   nginx.ingress.kubernetes.io/ssl-redirect: "false"
  #   nginx.ingress.kubernetes.io/use-regex: "true"
  #   nginx.ingress.kubernetes.io/rewrite-target: /$1
  set {
    name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/ssl-redirect"
    value = "false"
    type  = "string"
  }
  set {
    name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/use-regex"
    value = "true"
    type  = "string"
  }
  set {
    name  = "server.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = "/$1"
  }
  set {
    name  = "server.ingress.enabled"
    value = "true"
  }
  set {
    name  = "server.ingress.https"
    value = "true"
  }
  set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }
  set {
    name  = "server.ingress.pathType"
    value = "Prefix"
  }
  set {
    name  = "server.ingress.paths"
    value = "{/argocd(.*)}" # "[\"/argocd\"]"
  }
}

# https://github.com/goharbor/harbor-helm
resource "helm_release" "harbor" {
  name       = "harbor"
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  # version          = "1.4.0-dev"
  namespace        = "harbor"
  create_namespace = true

  set {
    name  = "expose.type"
    value = "ingress"
  }
  set {
    name = "harborAdminPassword"
    value = var.harbor_admin_password
  }
  set {
    name = "expose.ingress.className"
    value ="nginx"
  }
  set {
    name = "trace.enabled"
    value = "true"
  }
  set {
    name = "persistence.enabled"
    value ="true"
  }
  set {
    name = "clair.enabled"
    value ="true"
  }
  set {
    name = "notary.enabled"
    value ="true"
  }
  set {
    name = "trivy.enabled"
    value ="true"
  }
  set {
    name = "notary.enabled"
    value ="true"
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