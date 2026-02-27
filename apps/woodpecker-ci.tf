resource "kubernetes_manifest" "woodpecker-ci-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "woodpecker-ci"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "ssh://git@git.pieter.fish/pieter/argocd-manifests.git"
        path = "woodpecker-ci/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        namespace = "woodpecker"
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
