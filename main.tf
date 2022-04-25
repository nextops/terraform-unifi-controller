terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.19.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  # Configuration options
  token = var.do_token
}

resource "digitalocean_app" "unifi-controller" {
  
  spec {
    name   = "unifi-controller"
    region = "sfo"

    service {
      name               = "linuxserver-unifi-controller"
      instance_count     = 1
      instance_size_slug = "basic-xxs"

      image {
          registry      = "linuxserver"
          registry_type = "DOCKER_HUB"
          repository    = "unifi-controller"
          tag           = "7.0.25"
      }
    }
  }
}
