terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.19.0"
    }
  }
  cloud {
    organization = "NextOps"

    workspaces {
      name = "unifi-controller"
    }
  }
  required_version = ">= 1.1.9"
}

resource "digitalocean_app" "unifi-controller" {

  spec {
    name   = "unifi-controller"
    region = "sfo"

    service {
      name               = "linuxserver-unifi-controller"
      instance_count     = 1
      instance_size_slug = "basic-m"
      http_port          = 8080
      internal_ports = [
        8443,
        8843,
        8880
      ]

      image {
        registry      = "linuxserver"
        registry_type = "DOCKER_HUB"
        repository    = "unifi-controller"
        tag           = "7.0.25"
      }
    }
  }
}
