variable "mode" {
  description = "mode: mode"
}

variable "v_image" { 
  type = map
  description = "Image" 
    default = {
    mode = "shekeriev/bgapp-web"
  }
}  

variable "v_image_db" { 
  type = map
  description = "Image"
  default = {
    mode = "shekeriev/bgapp-db"
 }
} 