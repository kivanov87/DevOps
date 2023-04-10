terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker" 
        } 
    } 
}

provider "docker" {
    host = "tcp://192.168.99.100:2375/" 
}

resource "docker_network" "app_network" {
name = "app_network"
}

resource "docker_image" "img-web" {
name = "shekeriev/bgapp-web:latest"
}

resource "docker_image" "img-db" {
name = "shekeriev/bgapp-db:latest"
}

resource "docker_container" "con-web" {
name = "site"
image = docker_image.img-web.image_id
ports {
internal = "80"
external = "80"
  }
}

resource "docker_container" "con-db" {
name = "DB"
image = docker_image.img-web.image_id
ports {
internal = "3306"
external = "3306"
  }
}


#variables
