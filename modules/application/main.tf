resource "docker_image" "app" {
  name = var.image
}

resource "docker_container" "app" {
  image = docker_image.app.latest
  name  = "app"
  restart = "unless-stopped"
  env   = [
    "PORT=4000",
  ]
  ports {
    internal = "4000"
    external = "80"
  }
}