module "cilium" {
  source = "git::https://github.com/Pieter-Visscher/terraform-modules.git//cilium?ref=main"

  cilium_version = "1.18.3"
  ip_pool_start = "10.0.200.2"
  ip_pool_end = "10.0.200.254"
  ip_pool_interface = "bond0.200"
  devices = ["bond0.50", "bond0.200"]
  exclusive_cni = false
  chainingMode = "none"
  readOnlyRootfs = true
  mgt_ip_pool_start = "10.0.50.150"
  mgt_ip_pool_end = "10.0.50.199"
  ip_pool_mgt_interface = "bond0.50"
  gateway_api_version = "v1.4.0"
}

module "longhorn" {
  source = "git::https://github.com/Pieter-Visscher/terraform-modules.git//longhorn?ref=main"

  longhorn_version = "1.10.1"
}

module "argocd" {
  source = "git::https://github.com/Pieter-Visscher/terraform-modules.git//argocd?ref=main"

  argocd_version = "9.1.4"
}

module "kubevirt" {
  source = "git::https://github.com/Pieter-Visscher/terraform-modules.git//kubevirt?ref=main"

  kubevirt_operator_version = "v1.7.0"
  kubevirt_cdi_version = "v1.64.0"
}

module "apps" {
  source = "./apps"
}
