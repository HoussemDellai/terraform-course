# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment_v1
resource "kubernetes_deployment_v1" "deploy" {
  metadata {
    name      = "deploy-nginx"
    namespace = kubernetes_namespace_v1.ns.metadata.0.name

    labels = {
      tier = "frontend"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        tier = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          tier = "frontend"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "nginx"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
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
  }
}