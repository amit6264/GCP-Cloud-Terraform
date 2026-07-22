resource "google_artifact_registry_repository" "docker_repo" {

  project = var.project_id

  location = var.region

  repository_id = "${var.environment}-${var.repository_name}"

  description = "Docker Repository"

  format = "DOCKER"

  docker_config {

    immutable_tags = true

  }

}
