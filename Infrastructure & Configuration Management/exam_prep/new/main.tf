terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_network" "net-docker" {
  name = "exam-prep"
}

resource "docker_image" "img-zookeeper" {
  name = "bitnami/zookeeper:latest"
}

resource "docker_image" "img-kafka" {
  name       = "bitnami/kafka:latest"
  depends_on = [docker_image.img-zookeeper]
}

resource "docker_image" "img-exporter" {
  name = "danielqsj/kafka-exporter"
  #depends_on = [docker_image.img-kafka]
}

resource "docker_image" "img-prometheus" {
  name       = "prom/prometheus"
#  depends_on = [docker_image.img-kafka-cons]
}

resource "docker_image" "img-grafana" {
  name       = "grafana/grafana"
  depends_on = [docker_image.img-prometheus]
}

resource "docker_image" "img-kafka-prod" {
  name       = "shekeriev/kafka-prod"
#  depends_on = [docker_image.img-exporter]
}

resource "docker_image" "img-kafka-cons" {
  name       = "shekeriev/kafka-cons"
  depends_on = [docker_image.img-kafka-prod]
}

resource "docker_container" "zookeeper" {
  name  = "zookeeper"
  image = docker_image.img-zookeeper.image_id
  env   = ["ALLOW_ANONYMOUS_LOGIN=yes"]
  ports {
    internal = 2181
    external = 2181
  }
  networks_advanced {
    name = "exam-prep"
  }
}

resource "docker_container" "kafka" {
  name  = "kafka"
  image = docker_image.img-kafka.image_id
  env = ["KAFKA_BROKER_ID=1",
    "KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181",
  "ALLOW_PLAINTEXT_LISTENER=YES"]
  ports {
    internal = 9092
    external = 9092
  }
  networks_advanced {
    name = "exam-prep"
  }
  depends_on = [
    docker_container.zookeeper
  ]
}

resource "docker_container" "exporter" {
  name  = "exporter"
  image = docker_image.img-exporter.image_id
  env   = ["kafka.server=kafka:9092"]
  ports {
    internal = 9308
    external = 9308
  }
  networks_advanced {
    name = "exam-prep"
  }
  #depends_on = [docker_container.kafka]
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.img-prometheus.image_id
  ports {
    internal = 9090
    external = 9090
  }
  networks_advanced {
    name = "exam-prep"
  }
  volumes {
    host_path      = "/vagrant/monitoring/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }
#  depends_on = [docker_container.kafka-consumer]
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.img-grafana.image_id
  env   = ["ALLOW_ANONYMOUS_LOGIN=yes"]
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = "exam-prep"
  }
  volumes {
    host_path      = "/vagrant/monitoring/datasource.yml"
    container_path = "/etc/grafana/provisioning/datasources/datasource.yml"
    read_only      = true
  }
  depends_on = [docker_container.prometheus]
}

resource "docker_container" "kafka-producer" {
  name  = "kafka-producer"
  image = docker_image.img-kafka-prod.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=prep"]
  networks_advanced {
    name = "exam-prep"
  }
#  depends_on = [docker_container.exporter]
}

resource "docker_container" "kafka-consumer" {
  name  = "kafka-consumer"
  image = docker_image.img-kafka-cons.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=prep"]
  networks_advanced {
    name = "exam-prep"
  }
  depends_on = [docker_container.kafka-producer]
}