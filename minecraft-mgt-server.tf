resource "kubernetes_manifest" "minecraft-mgt-server-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "minecrfat-mgt-server"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
        path = "minecraft-mgt-server/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        namespace = "minecraft-mgt-server"
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
