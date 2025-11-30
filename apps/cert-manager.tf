resource "kubernetes_manifest" "cert-manager-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "cert-manager"
    }
    spec = {
      project = "default"
      source = {
        path           = "."
        repoURL        = "oci://quay.io/jetstack/charts/cert-manager"
        targetRevision = "v1.19.1"
        helm = {
          valuesObject = {
            crds = {
              enabled = true
            }
            config = {
              apiVersion = "controller.config.cert-manager.io/v1alpha1"
              kind = "ControllerConfiguration"
              enableGatewayAPI = true
            }
          }
        }
      }
      destination = {
        namespace = "cert-manager"
        server = "https://kubernetes.default.svc"
      }
      syncPolicy = {
        automated = {
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=true", "ServerSideApply=true"
        ]
      }
    }
  }
}
