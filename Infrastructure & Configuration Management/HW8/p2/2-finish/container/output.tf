output "container-id" {
  value = docker_container.con-web.id
}

output "container-name" { 
  value = docker_container.con-web.name
}
#DB CONTAINER
output "container-id-db" {
  value = docker_container.con-db.id
}

output "container-name-db" { 
  value = docker_container.con-db.name
}
