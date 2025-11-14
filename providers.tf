provider "kubernetes" {
  host = "https://10.0.50.254:6443"

  client_certificate     = file("~/.kube/talos/client-cert.pem")
  client_key             = file("~/.kube/talos/client-key.pem")
  cluster_ca_certificate = file("~/.kube/talos/cluster-ca-cert.pem")
}

provider "helm" {
  kubernetes {
    host                   = "https://10.0.50.254:6443"
    client_certificate     = file("~/.kube/talos/client-cert.pem")
    client_key             = file("~/.kube/talos/client-key.pem")
    cluster_ca_certificate = file("~/.kube/talos/cluster-ca-cert.pem")
  }
}
