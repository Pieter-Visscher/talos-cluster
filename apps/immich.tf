resource "kubernetes_manifest" "immich-helm-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace = "argocd"
      name      = "immich-helm"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "ghcr.io/immich-app/immich-charts"
        chart          = "immich"
        targetRevision = "0.10.3"
        helm = {
          valuesObject = {
            server = {
              controllers = {
                main = {
                  containers = {
                    main = {
                      env = {
                        DB_HOSTNAME = {
                          valueFrom = {
                            secretKeyRef = {
                              name = "immich-database-app"
                              key  = "host"
                            }
                          }
                        },
                        DB_USERNAME = {
                          valueFrom = {
                            secretKeyRef = {
                              name = "immich-database-app"
                              key  = "user"
                            }
                          }
                        },
                        DB_PASSWORD = {
                          valueFrom = {
                            secretKeyRef = {
                              name = "immich-database-app"
                              key  = "password"
                            }
                          }
                        },
                        DB_DATABASE_NAME = {
                          valueFrom = {
                            secretKeyRef = {
                              name = "immich-database-app"
                              key  = "dbname"
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            controllers = {
              main = {
                image = {
                  tag = "v2.3.1"
                }
              }
            },
            valkey = {
              enabled = true
            },
            immich = {
              persistence = {
                library = {
                  existingClaim = "immich-library-pvc"
                }
              }
            }
          }
        }
      }
      destination = {
        namespace = "immich"
        server    = "https://kubernetes.default.svc"
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

resource "kubernetes_manifest" "immich-manifests-argocd" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      namespace  = "argocd"
      name = "immich-manifests"
    }
    spec = {
      project = "default"
      source = {
        repoURL = "git@github.com:Pieter-Visscher/kubernetes-argo.git"
        path = "immich/"
        targetRevision = "HEAD"
        kustomize      = {}
      }
      destination = {
        server = "https://kubernetes.default.svc"
        namespace = "immich"
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
