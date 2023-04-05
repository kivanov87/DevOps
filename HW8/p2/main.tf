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

resource "docker_container" "bgapp-web" {
    name = "shekeriev/bgapp-web"
    image = docker_image.img-web.image_id
    ports {
        internal = "80" 
        external = "80" 
    } 
}