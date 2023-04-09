terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.99.100:2375/"
}

resource "docker_network" "app" {
  name = "app"
}

resource "docker_image" "img-web" {
  name = "shekeriev/bgapp-web"
}

resource "docker_image" "img-db" {
  name = "shekeriev/bgapp-db"
}

resource "docker_container" "db" {
  name  = "bgapp-db"
  image = "docker_image.img-db"
  networks_advanced {
    name = docker_network.app.name
    aliases = ["db"]
  }
}

resource "docker_container" "web" {
  name  = "bgapp-web"
  image = "docker_image.img-web"
  ports {
    internal = 80
    external = 8080
  }
  networks_advanced {
    name = docker_network.app.name
    aliases = ["web"]
  }
  depends_on = [docker_container.db]

  command = [
    "/bin/sh",
    "-c",
    "chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html && apache2-foreground"
  ]
}