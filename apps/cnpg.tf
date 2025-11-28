resource "kubernetes_manifest" "cnpg-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "cnpg"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "https://cloudnative-pg.github.io/charts"
        chart = "cloudnative-pg"
        targetRevision = "v0.26.1"
      }
      destination = {
        namespace = "cnpg-system"
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
