variable "mode" {
  description = "mode: mode"
}

variable "v_image" {
  description = "Image"
  default = {
    mode = "shekeriev/bgapp-web:latest"
  }
}

variable "v_con_name" {
  description = "Container name"
  default = {
    mode = "con-web"
  }
}

variable "v_int_port" {
  description = "Internal port"
  default = {
    mode = 80
  }
}

variable "v_ext_port" {
  description = "External port"
  default = {
    mode = 80
  }
}

#DB
variable "v_image_db" {
  description = "Image"
  default = {
    mode = "shekeriev/bgapp-db:latest"
  }
}

variable "v_con_name_db" {
  description = "Container name"
  default = {
    mode = "con-db"
  }
}
variable "v_int_port_db" {
  description = "Internal port"
  default = {
    mode = 3306
  }
}

variable "v_ext_port_db" {
  description = "External port"
  default = {
    mode = 3306
  }
}