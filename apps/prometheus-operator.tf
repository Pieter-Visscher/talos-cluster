resource "kubernetes_manifest" "prometheus-operator-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "prometheus-operator"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "ssh://git@git.pieter.fish/pieter/argocd-manifests.git"
        path = "prometheus-operator/"
        targetRevision = "HEAD"
        kustomize      = {}
      }
      destination = {
        server = "https://kubernetes.default.svc"
        namespace = "monitoring"
      }
      syncPolicy = {
        managedNamespaceMetadata = {
          labels = {
            gateway-access = true
          }
        }
        automated = {
          selfHeal = true
        }
        syncOptions = [
          "CreateNameSpace=true",
          "ServerSideApply=true"
        ]
      }
    }
  }
}
