terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "cluster01" {
  name   = var.k8s_name
  region = var.k8s_region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.22.8-do.1"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 3

  }
}

variable "do_token" {}
variable "k8s_name" {}
variable "k8s_region" {}

output "kube_endpoint" {
    value = digitalocean_kubernetes_cluster.cluster01.endpoint
}

resource "local_file" "name" {
  content = digitalocean_kubernetes_cluster.cluster01.kube_config.0.raw_config
  filename = "kube_config.yaml"
}
