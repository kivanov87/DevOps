output "container-id" {
  value = docker_container.con-web.id
}

output "container-name" {
  value = docker_container.con-web.name
}

output "container-id_db" {
  value = docker_container.con-db.id
}

output "container-name_db" {
  value = docker_container.con-db.name
}