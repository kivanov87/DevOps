terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "img-kafka-prod" {
  name       = "shekeriev/kafka-discoverer"
}

resource "docker_image" "img-kafka-cons" {
  name       = "shekeriev/kafka-observer"
  depends_on = [docker_image.img-kafka-prod]
}

resource "docker_container" "kafka-producer" {
  name  = "kafka-producer"
  image = docker_image.img-kafka-prod.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=animal-facts", "METRICPORT=8000"]
  ports {
    internal = 8000
    external = 8000
  }
  networks_advanced {
    name = "appnet"
  }
}

resource "docker_container" "kafka-consumer" {
  name  = "kafka-consumer"
  image = docker_image.img-kafka-cons.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=animal-facts", "APPPORT=5000"]
  ports {
    internal = 5000
    external = 5000
  }
  networks_advanced {
    name = "appnet"
  }
  depends_on = [docker_container.kafka-producer]
}