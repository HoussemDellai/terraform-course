# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_v1
resource "kubernetes_pod_v1" "pod_nginx" {
  metadata {
    name      = "pod-nginx"
    namespace = kubernetes_namespace_v1.ns.metadata.0.name
  }

  spec {
    container {
      image = "nginx:1.21.6"
      name  = "nginx"

      env {
        name  = "environment"
        value = "test"
      }

      port {
        container_port = 80
      }

      liveness_probe {
        http_get {
          path = "/"
          port = 80

          http_header {
            name  = "X-Custom-Header"
            value = "Awesome"
          }
        }

        initial_delay_seconds = 3
        period_seconds        = 3
      }
    }
  }
}