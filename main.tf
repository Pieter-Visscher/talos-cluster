module "cilium" {
  source = "git::https://github.com/Pieter-Visscher/terraform-modules.git//cilium?ref=main"

  cilium_version = "1.18.3"
  ip_pool_start = "10.0.200.2"
  ip_pool_end = "10.0.200.254"
  ip_pool_interface = "bond0.200"
  devices = ["bond0", "bond0.200"]
  exclusive_cni = true
}

module "longhorn" {
  source = "git::https://github.com/Pieter-Visscher/terraform-modules.git//longhorn?ref=main"

  longhorn_version = "1.10.0"
}

module "argocd" {
  source = "git::https://github.com/Pieter-Visscher/terraform-modules.git//argocd?ref=main"

  argocd_version = "8.1.2"
}
#
module "apps" {
  source = "./apps"
}
