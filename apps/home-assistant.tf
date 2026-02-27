resource "kubernetes_manifest" "home-assistant-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "home-assistant"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
        path = "home-assistant/"
        targetRevision = "HEAD"
        directory = {
          recurse = true
        }
      }
      destination = {
        namespace = "home-assistant"
        server = "https://kubernetes.default.svc"
      }
      syncPolicy = {
        managedNamespaceMetadata = {
          labels = {
            "pod-security.kubernetes.io/enforce" =  "privileged"
            "pod-security.kubernetes.io/audit" = "privileged"
            "pod-security.kubernetes.io/warn"  = "privileged"
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
