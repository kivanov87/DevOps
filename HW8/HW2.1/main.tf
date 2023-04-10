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

module "image" {
  source = "./image" 
  v_image = lookup(var.v_image)
  v_image_db = lookup(var.v_image_db)
}

module "container" {
  source = "./container"
  v_image = module.image.image_out
  v_image_db = module.image.image_out_db
  v_con_name = lookup(var.v_con_name)
  v_con_name_db = lookup(var.v_con_name_db)
  v_int_port = lookup(var.v_int_port)
  v_int_port_db = lookup(var.v_int_port_db)
  v_ext_port = lookup(var.v_ext_port)
  v_ext_port_db = lookup(var.v_ext_port_db)
}
