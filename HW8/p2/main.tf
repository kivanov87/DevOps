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

resource "docker_container" "db_container" {
  name  = "bgapp-db"
  image = "shekeriev/bgapp-db"
  ports {
    internal = 3306
    external = 3306
  }
  env = [
    "MYSQL_ROOT_PASSWORD=<password>",
    "MYSQL_DATABASE=<database>"
  ]
  networks_advanced {
    name = docker_network.app_network.name
  }
}