output "image_out" {
value = docker_image.img-web.name
}

output "image_out_db" {
value = docker_image.img-db.name
}
