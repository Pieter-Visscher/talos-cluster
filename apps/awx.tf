resource "kubernetes_manifest" "awx-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "awx"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "ssh://git@git.pieter.fish/pieter/argocd-manifests.git"
        path = "awx/"
        targetRevision = "HEAD"
        kustomize      = {}
      }
      destination = {
        server = "https://kubernetes.default.svc"
        namespace = "awx"
      }
      syncPolicy = {
        automated = {
          selfHeal = true
        }
        syncOptions = [
          "CreateNameSpace=true"
        ]
      }
    }
  }
}
