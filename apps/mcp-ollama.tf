resource "kubernetes_manifest" "qdrant-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "qdrant"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "ssh://git@git.pieter.fish/pieter/argocd-manifests.git"
        path = "qdrant/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        namespace = "git-mcp"
        server = "https://kubernetes.default.svc"
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
          "CreateNamespace=true"
        ]
      }
    }
  }
}
