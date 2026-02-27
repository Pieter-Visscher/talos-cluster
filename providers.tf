terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubernetes" {
  host = "https://10.0.50.200:6443"

  client_certificate     = file("~/.kube/talos/client-cert.pem")
  client_key             = file("~/.kube/talos/client-key.pem")
  cluster_ca_certificate = file("~/.kube/talos/cluster-ca-cert.pem")
}

provider "kubectl" {
  host = "https://10.0.50.254:6443"
  client_certificate     = file("~/.kube/talos/client-cert.pem")
  client_key             = file("~/.kube/talos/client-key.pem")
  cluster_ca_certificate = file("~/.kube/talos/cluster-ca-cert.pem")
  load_config_file       = false
}


provider "helm" {
  kubernetes {
    host                   = "https://10.0.50.254:6443"
    client_certificate     = file("~/.kube/talos/client-cert.pem")
    client_key             = file("~/.kube/talos/client-key.pem")
    cluster_ca_certificate = file("~/.kube/talos/cluster-ca-cert.pem")
  }
}
