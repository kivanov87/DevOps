variable "mode" {
  description = "mode: mode"
}

variable "v_image" { 
  description = "WEB" 
    default = "shekeriev/bgapp-web"
}
  
variable "v_image_db" { 
  description = "DB"
  default = "shekeriev/bgapp-db"
} 