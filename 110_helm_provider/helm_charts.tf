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

# resource "helm_release" "nginx_ingress" {
#   name             = "nginx-ingress-controller"
#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "nginx-ingress-controller"
#   namespace        = "nginx-ingress"
#   create_namespace = true

#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }
# }

# https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
resource "helm_release" "prometheus_stack" {
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  provisioner "local-exec" {
    command = "kubectl describe ingress prometheus-stack-grafana -n monitoring >> ingress.txt"
  }

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


  # set {
  #   name  = "prometheus.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/ssl-redirect"
  #   value = "false"
  #   type  = "string"
  # }
  # set {
  #   name  = "prometheus.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/use-regex"
  #   value = "true"
  #   type  = "string"
  # }
  # set {
  #   name  = "prometheus.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
  #   value = "/$1"
  # }
  # set {
  #   name  = "prometheus.ingress.enabled"
  #   value = "true"
  # }
  # set {
  #   name  = "prometheus.ingress.ingressClassName"
  #   value = "nginx"
  # }
  # set {
  #   name  = "prometheus.ingress.paths"
  #   value = "{/prometheus/?(.*)}"
  # }
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
  # set {
  #   name = "server.ingress.annotations"
  #   value = "{nginx.ingress.kubernetes.io/ssl-redirect: "false",nginx.ingress.kubernetes.io/use-regex: "true",nginx.ingress.kubernetes.io/rewrite-target: /$1}"
  # }
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
  # set {
  #   name  = "server.service.type"
  #   value = "LoadBalancer"
  # }
}

# resource "helm_release" "argo_cd" {
#   name             = "argo"
#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "argo-cd"
#   version          = "3.3.8"
#   namespace        = "gitops"
#   create_namespace = true

#   set {
#     name  = "server.service.type"
#     value = "LoadBalancer"
#   }
# }


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

# # https://github.com/bitnami/charts/tree/master/bitnami/harbor
# resource "helm_release" "harbor" {
#   name             = "harbor"
#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "harbor"
#   version          = "13.2.4"
#   namespace        = "harbor"
#   create_namespace = true

#   set {
#     name = "adminPassword"
#     value = var.harbor_admin_password
#   }
#   set {
#     name = "exposureType"
#     value = "ingress"
#   }
#   set {
#     name = "ingress.core.ingressClassName"
#     value ="nginx"
#   }
#   set {
#     name = "persistence.enabled"
#     value ="true"
#   }
#   set {
#     name = "clair.enabled"
#     value ="true"
#   }
#   set {
#     name = "notary.enabled"
#     value ="true"
#   }
#   set {
#     name = "trivy.enabled"
#     value ="true"
#   }
#   set {
#     name = "notary.enabled"
#     value ="true"
#   }
#   set {
#     name  = "ingress.core.hostname"
#     value = ""
#   }
# }

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