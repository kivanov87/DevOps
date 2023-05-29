terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}

resource "docker_network" "kafka_network" {
  name = "kafka_network"
}

resource "docker_container" "zookeeper" {
  image   = "bitnami/zookeeper:latest"
  name    = "zookeeper"
  ports {
    internal = 2181
    external = 2181
  }
  env = [
    "ALLOW_ANONYMOUS_LOGIN=YES",
  ]
  networks_advanced {
    name = "kafka_network"
  }
}

resource "docker_container" "kafka" {
  image      = "bitnami/kafka:latest"
  name       = "kafka"
  ports {
    internal = 9092
    external = 9092
  }
  env = [
    "KAFKA_BROKER_ID=1",
    "KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181",
    "ALLOW_PLAINTEXT_LISTENER=yes",
  ]
    depends_on = [ 
    docker_container.zookeeper,
  ]
  networks_advanced {
    name = "kafka_network"
  }
}

resource "docker_container" "exporter" {
  image   = "danielqsj/kafka-exporter"
  name    = "exporter"
  ports {
    internal = 9308
    external = 9308
  }
  env = ["kafka.server=kafka:9092"]
  networks_advanced {
    name = "kafka_network"
  }
}

