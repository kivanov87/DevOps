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

resource "docker_container" "con-web" {
  name  = "site"
  image = docker_image.img-web.image_id

  ports {
    internal = "80"
    external = "80"
  }

  # Connect to the same Docker network as con-db
  network_mode = docker_network.net.name

  # Set environment variables for database connection
  environment = [
    "DB_HOST=${docker_container.con-db.ip_address}",
    "DB_USER=myuser",
    "DB_PASS=mypassword",
    "DB_NAME=mydatabase",
  ]
}

resource "docker_container" "con-db" {
  name  = "DB"
  image = docker_image.img-db.image_id

  ports {
    internal = "3306"
    external = "3306"
  }

  # Connect to the same Docker network as con-web
  network_mode = docker_network.net.name

  # Set environment variables for database configuration
  environment = [
    "MYSQL_ROOT_PASSWORD=12345",
    "MYSQL_DATABASE=mydatabase",
  ]
}

# Define the Docker network
resource "docker_network" "net" {
  name = "my-network"
}
#variables
