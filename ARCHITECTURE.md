# Architecture

## Goal

Terraform configuration that provisions and manages the complete homelab Kubernetes cluster. Covers cluster networking (Cilium), distributed storage (Longhorn), GitOps (ArgoCD), virtualisation (KubeVirt), and all application deployments — as a single, version-controlled stack.

## Design

A single Terraform root module that composes infrastructure from reusable modules in the `terraform-modules` repository (sourced via Git reference). The cluster runs Talos Linux on bare metal at `10.0.50.200:6443`.

ArgoCD is bootstrapped by Terraform and subsequently manages all application deployments from the `argocd-manifests` repository.

## Cluster Infrastructure

Provisioned by the root module via `terraform-modules`:

| Module | Version | Purpose |
|---|---|---|
| `cilium` | 1.18.3 | CNI — pod networking, Gateway API, load balancer IP pools |
| `longhorn` | 1.10.1 | Distributed block storage for PersistentVolumes |
| `argocd` | 9.1.4 | GitOps engine — deploys all applications |
| `kubevirt` | operator v1.7.0, CDI v1.64.0 | Virtual machine runtime |

### Cilium Network Configuration

- Management network: `10.0.50.150–10.0.50.199` (interface `bond0.50`)
- Application load balancer pool: `10.0.200.2–10.0.200.254` (interface `bond0.200`)
- Gateway API: v1.4.0

## Application Deployments (`apps/`)

Each file under `apps/` provisions an ArgoCD `Application` resource pointing at the `argocd-manifests` repository:

| File | Application |
|---|---|
| `awx.tf` | AWX — Ansible automation |
| `bitwarden.tf` | Bitwarden — password manager |
| `cert-manager.tf` | cert-manager — TLS certificate automation |
| `cnpg.tf` | CloudNativePG — PostgreSQL operator |
| `dawarich.tf` | Dawarich — location history |
| `forgejo.tf` | Forgejo — Git server |
| `home-assistant.tf` | Home Assistant |
| `immich.tf` | Immich — photo library |
| `intel-device-plugin.tf` | Intel GPU device plugin |
| `metrics.tf` | metrics-server |
| `multus.tf` | Multus CNI |
| `network.tf` | Gateway API, TLS certificates |
| `nextcloud.tf` | Nextcloud |
| `nfd.tf` | Node Feature Discovery |
| `omni-tools.tf` | omni-tools |
| `opa.tf` | Open Policy Agent |
| `paperless-ngx.tf` | Paperless-ngx |
| `pieter-fish.tf` | pieter.fish personal site |
| `prometheus-operator.tf` | Prometheus Operator |
| `woodpecker-ci.tf` | Woodpecker CI |
| `zot-registry.tf` | Zot container registry |

## Talos Configuration (`talos-config/`)

Talos Linux machine configs are generated via `gen-config.sh` and composed from patches:

| Patch | Purpose |
|---|---|
| `patches/cluster.yaml` | Cluster-wide settings |
| `patches/controlplane.yaml` | Control plane configuration |
| `patches/network.yaml` | Node networking |
| `patches/storage.yaml` | Disk and storage layout |
| `patches/secrets.yaml` | Cluster secrets (gitignored) |
| `patches/controlplane-{0,1,2}.yaml` | Per-node overrides |

## Repository Structure

```
talos-cluster/
├── main.tf                    # Root module — cilium, longhorn, argocd, kubevirt
├── providers.tf               # Kubernetes, kubectl, Helm providers
├── terraform.tf               # Terraform Cloud backend, version constraints
├── minecraft-mgt-server.tf    # Minecraft management server
├── apps/                      # ArgoCD Application resources per app
├── talos-config/
│   ├── gen-config.sh
│   └── patches/               # Machine config patches
└── .envrc                     # direnv environment variables
```
