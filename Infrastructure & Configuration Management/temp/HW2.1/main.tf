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

resource "docker_network" "private_network" {
  name = "app"
}

module "image" {
  source     = "./image"
  mode       = var.mode
  v_image    = lookup(var.v_image, var.mode)
  v_image_db = lookup(var.v_image_db, var.mode)
}

module "container" {
  source        = "./container"
  v_image       = module.image.image_out
  v_image_db    = module.image.image_out_db
  v_con_name    = lookup(var.v_con_name, var.mode)
  v_con_name_db = lookup(var.v_con_name_db, var.mode)
  v_int_port    = lookup(var.v_int_port, var.mode)
  v_int_port_db = lookup(var.v_int_port_db, var.mode)
  v_ext_port    = lookup(var.v_ext_port, var.mode)
  v_ext_port_db = lookup(var.v_ext_port_db, var.mode)
}
