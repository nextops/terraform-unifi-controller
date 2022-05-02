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
      name               = "unifi-controller-service"
      instance_count     = 1
      instance_size_slug = "basic-m"
      http_port          = 8080
      internal_ports = [
        3478,
        6789,
        8443,
        8843,
        8880,
        10001
      ]
      routes {
        path                 = "/"
        preserve_path_prefix = "true"
      }

      image {
        registry      = "jacobalberty"
        registry_type = "DOCKER_HUB"
        repository    = "unifi"
        tag           = "v7.0.25"
      }
    }
  }
}
