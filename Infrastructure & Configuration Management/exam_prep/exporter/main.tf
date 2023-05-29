terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}

resource "docker_container" "exporter" {
  image   = "danielqsj/kafka-exporter"
  name    = "zookeeper"
  ports {
    internal = 9308
    external = 9308
  }
  env = ["kafka.server=kafka:9092"]
  networks_advanced {
    name = "kafka_network"
  }
}

resource "docker_container" "exporter" {
  image   = "danielqsj/kafka-exporter"
  name    = "zookeeper"
  ports {
    internal = 9308
    external = 9308
  }
  env = ["kafka.server=kafka:9092"]
  networks_advanced {
    name = "kafka_network"
  }
}