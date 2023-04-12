variable "v_image" {
  description = "Image"
  type = string
  default = "shekeriev/bgapp-web"
}

variable "v_con_name" {
  description = "Container name"
  type = map
}

variable "v_int_port" {
  description = "Internal port"
  type = number
  default = 80
}

variable "v_ext_port" {
  description = "External port"
  type = number
  default = 80
}
##DB
variable "v_image_db" {
  description = "Image"
  type = string
  default = "shekeriev/bgapp-db"
}

variable "v_con_name_db" {
  description = "Container name"
  type = string
  default = "con-db"
}

variable "v_int_port_db" {
  description = "Internal port"
  type = number
  default = 3306
}

variable "v_ext_port_db" {
  description = "External port"
  type = number
  default = 3306
}
