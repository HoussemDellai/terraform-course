resource "kubernetes_service_v1" "svc" {
  metadata {
    name      = "frontend-svc"
    namespace = kubernetes_namespace_v1.ns.metadata.0.name
  }
  spec {
    selector = {
      tier = kubernetes_deployment_v1.deploy.spec.0.template.0.metadata.0.labels.tier
    }
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}