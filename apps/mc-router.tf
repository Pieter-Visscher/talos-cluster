resource "kubernetes_manifest" "mc-router-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "mc-router"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
        path = "mc-router/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        namespace = "minecraft"
        server = "https://kubernetes.default.svc"
      }
      syncPolicy = {
        managedNamespaceMetadata = {
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
