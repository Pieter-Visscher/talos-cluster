resource "kubernetes_manifest" "secrets-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "secrets"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "ssh://git@git.pieter.fish/pieter/argocd-secrets.git"
        path = "."
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        server = "https://kubernetes.default.svc"
      }
      syncPolicy = {
        automated = {
          selfHeal = true
        }
        syncOptions = [
        ]
      }
    }
  }
}
