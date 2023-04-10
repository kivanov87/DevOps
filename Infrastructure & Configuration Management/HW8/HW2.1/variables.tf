variable "mode" { 
  description = "mode"
}
variable "v_image" { 
  description = "Image" 
  default = "shekeriev/bgapp-web"
}

variable "v_con_name" {
  description = "Container name"
  default = "con-web"
}

variable "v_int_port" {
  description = "Internal port"
  default = 80
}

variable "v_ext_port" {
  description = "External port"
  default = 80 
}
#DB
variable "v_image_db" { 
  description = "Image"
  default =  "shekeriev/bgapp-db"
}

variable "v_con_name_db" {
  description = "Container name"
  default = "con-db"
}

variable "v_int_port_db" {
  description = "Internal port"
  default = 3306 
}

variable "v_ext_port_db" {
  description = "External port"
  default = 3306 
}
