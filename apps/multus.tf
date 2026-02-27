resource "kubernetes_manifest" "multus-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "multus"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
        path = "multus/"
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
