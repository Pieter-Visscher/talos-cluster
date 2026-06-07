resource "kubernetes_manifest" "zot-registry-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "zot-registry"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "ssh://git@git.pieter.fish/pieter/argocd-manifests.git"
        path = "zot-registry/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        namespace = "zot-registry"
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
