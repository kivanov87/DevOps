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

resource "docker_network" "private_network" {
  name = "app"
}

resource "docker_image" "WEB" {
  name = var.v_image
}

resource "docker_image" "DB" {
  name = var.v_image_db
}